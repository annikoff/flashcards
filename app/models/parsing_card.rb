# frozen_string_literal: true
class ParsingCard < ApplicationRecord
  belongs_to :parsing
  belongs_to :card
  validates :parsing_id, :card_id, presence: true
end
