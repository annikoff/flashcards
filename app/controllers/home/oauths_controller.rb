# frozen_string_literal: true
module Home
  class OauthsController < Home::BaseController
    # sends the user on a trip to the provider,
    # and after authorizing there back to the callback url.
    def oauth
      login_at(auth_params[:provider])
    end

    def callback
      provider = auth_params[:provider]
      @user = login_from(provider)
      if @user
        track_oauth_login
        redirect_to trainer_path,
                    notice: t('global.notices.log_in_is_successful_provider'),
                    provider: provider.titleize
      else
        begin
          @user = create_from(provider)
          reset_session
          auto_login(@user)
          track_oauth_login
          redirect_to trainer_path,
                      notice: t('global.notices.log_in_is_successful_provider'),
                      provider: provider.titleize
        rescue
          redirect_to user_sessions_path,
                      alert: t('global.alerts.log_out_failed_provider'),
                      provider: provider.titleize
        end
      end
    end

    private

    def auth_params
      params.permit(:code, :provider)
    end

    def track_oauth_login
      ahoy.track 'oauth_login'
    end
  end
end
