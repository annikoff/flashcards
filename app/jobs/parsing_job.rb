# frozen_string_literal: true
class ParsingJob < ActiveJob::Base
  queue_as :default

  def perform(user, params)
    parser = Flashcards::Parser.new params[:url],
                                    params[:original_text_selector],
                                    params[:translated_text_selector]
    cards = parser.parse.map do |texts|
      texts[:block_id] = params[:block_id]
      card = user.cards.new texts
      card if card.save
    end
    CardsMailer.cards_created_by_parsing user.email, cards.compact
  end
end
