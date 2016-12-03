# frozen_string_literal: true
module Dashboard
  class ProfileController < Dashboard::BaseController
    def edit; end

    def update
      if current_user.update(user_params)
        redirect_to edit_profile_path,
                    notice: t('global.notices.user_successfully_updated')
      else
        respond_with current_user
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation,
                                   :locale)
    end
  end
end
