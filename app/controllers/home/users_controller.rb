# frozen_string_literal: true
module Home
  class UsersController < Home::BaseController
    def new
      if current_user
        redirect_to root_path
      else
        @user = User.new
      end
    end

    def create
      @user = User.new(user_params)
      if @user.save
        auto_login(@user)
        track_user_registration
        redirect_to root_path,
                    notice: t('global.notices.user_created_successfully')
      else
        respond_with @user
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def track_user_registration
      ahoy.track 'user_registration'
    end
  end
end
