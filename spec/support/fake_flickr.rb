# frozen_string_literal: true
class FakeFlickr
  def call(env)
    case env['PATH_INFO']
    when '/services/rest/'
      method = Rack::Request.new(env).params['method']
      [200, {}, [file_response("#{method}.json")]]
    when /.*\.jpg/
      [200, {}, [file_response('cat.jpg')]]
    else
      [404, {}, []]
    end
  end

  private

  def file_response(file_name)
    path = RSpec.configuration.fixture_path
    File.open("#{path}/#{file_name.underscore}", 'rb').read
  end
end
