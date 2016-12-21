# frozen_string_literal: true
module Analytics
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    layout 'analytics/application'
  end
end
