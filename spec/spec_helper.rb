# frozen_string_literal: true
require 'simplecov'
SimpleCov.start
require 'factory_girl_rails'
require 'support/capybara'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.before(:each) do
    stub_request(:any, /flickr.com/).to_rack(FakeFlickr)
  end
end
