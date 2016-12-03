# frozen_string_literal: true
module Home
  class UserSessionsController < Home::BaseController
    def new
      if current_user
        redirect_to root_path
      else
        @user = User.new
      end
    end

    def create
      @user = login(user_params[:email], user_params[:password])
      if @user
        redirect_back_or_to root_path,
                            notice: t('global.notices.log_in_is_successful')
      else
        redirect_to login_path, alert: t('global.alerts.not_logged_in')
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
