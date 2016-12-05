# frozen_string_literal: true
require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  before_action :set_locale

  private

  def not_authenticated
    redirect_to login_path, alert: t('global.alerts.please_log_in')
  end

  def set_locale
    session[:locale] = I18n.locale = locale
  end

  def locale
    locale = current_user&.locale ||
             params[:user_locale] ||
             session[:locale] ||
             compatible_language

    return locale if I18n.available_locales.include?(locale&.to_sym)
    I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def compatible_language
    http_accept_language.compatible_language_from(I18n.available_locales)
  end
end
