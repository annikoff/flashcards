# frozen_string_literal: true
class ParsingJob < ActiveJob::Base
  queue_as :default

  def perform(parsing)
    parsing.parse!
  end
end
