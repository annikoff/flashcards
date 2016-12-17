class Parsing < ApplicationRecord
  has_many :cards, through: :parsing_cards, dependent: :destroy
  has_many :parsing_cards, dependent: :destroy
  belongs_to :user
  belongs_to :block
  validates :user_id, :original_text_selector, :translated_text_selector,
            presence: true
  validates :url,
            presence: true,
            format: {
              with: %r{^#{URI::regexp(['http', 'https'])}},
              multiline: true,
              on: :create
            }

  def parse
    parser = Flashcards::Parser.new url,
                                    original_text_selector,
                                    translated_text_selector
    result = parser.parse
    result.each do |texts|
      texts[:block_id] = block_id
      texts[:user_id] = user_id
      card = Card.new texts
      self.parsing_cards.create card_id: card.id if card.save
    end
    self.error = nil
  rescue Exception => exception
    self.error = exception.message
  end

  def parse!
    parse
    save!
  end
end
