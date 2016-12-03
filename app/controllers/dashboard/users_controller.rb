# frozen_string_literal: true
module Dashboard
  class UsersController < Dashboard::BaseController
    def destroy
      current_user.destroy
      redirect_to login_path,
                  notice: t('global.notices.user_successfully_deleted')
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end
