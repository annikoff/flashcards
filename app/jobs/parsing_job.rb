class ParsingJob < ActiveJob::Base
  queue_as :default

  def perform(params)
    Flashcards::Parser.new(params).parse
  end
end
