# frozen_string_literal: true
module Dashboard
  class BaseController < ApplicationController
    before_action :require_login
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    private

    def not_authenticated
      redirect_to login_path, alert: t('global.alerts.please_log_in')
    end

    def not_found
      redirect_to root_path, alert: t('global.alerts.not_found')
    end
  end
end
