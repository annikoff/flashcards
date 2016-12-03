# frozen_string_literal: true
module Dashboard
  class UserSessionsController < Dashboard::BaseController
    def destroy
      logout
      redirect_to login_path, notice: t('global.notices.log_out_is_successful')
    end
  end
end
