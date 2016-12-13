# frozen_string_literal: true
require 'capybara/rspec'
require 'capybara-webkit'

Capybara.javascript_driver = :webkit
Capybara::Webkit.configure do |config|
  config.allow_url('farm1.staticflickr.com')
end
