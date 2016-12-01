# frozen_string_literal: true
module CardFinder
  extend ActiveSupport::Concern

  def find_card(id)
    current_user.cards.find id
  end
end
