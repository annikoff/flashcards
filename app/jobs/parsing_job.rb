# frozen_string_literal: true
class ParsingJob < ActiveJob::Base
  queue_as :default

  def perform(params)
    block = Block.find params[:block_id]
    cards = block.cards.new Flashcards::Parser.new(params).parse
    block.user.cards << cards
    CardsMailer.cards_created_by_parsing(block.user.email, cards).deliver_now
  end
end
