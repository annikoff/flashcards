# frozen_string_literal: true
class FakeExample < FakeHost
  def call(_env)
    [200, {}, [file_response('example.html')]]
  end
end
