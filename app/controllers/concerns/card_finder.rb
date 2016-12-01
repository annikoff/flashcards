module CardFinder
  extend ActiveSupport::Concern

  def find_card(id)
    current_user.cards.find id
  end
end
