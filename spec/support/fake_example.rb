# frozen_string_literal: true
class FakeExample < FakeHost
  def call(_env)
    [404, {}, [file_response('example.html')]]
  end
end
