# frozen_string_literal: true
class FakeFlickr < FakeHost
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
end
