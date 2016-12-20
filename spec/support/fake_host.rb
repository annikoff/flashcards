# frozen_string_literal: true
class FakeHost
  private

  def file_response(file_name)
    path = RSpec.configuration.fixture_path
    File.open("#{path}/#{file_name.underscore}", 'rb').read
  end
end
