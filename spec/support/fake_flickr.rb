# frozen_string_literal: true
require 'sinatra/base'

class FakeFlickr < Sinatra::Base
  post '/services/rest/' do
    json_response 200, "#{params['method']}.#{params['format']}"
  end

  get %r{/\.*\/\.jpg/} do
    send_file File.expand_path('cat.jpg', RSpec.configuration.fixture_path)
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    path = RSpec.configuration.fixture_path
    File.open("#{path}/#{file_name.underscore}", 'rb').read
  end
end
