# frozen_string_literal: true
module FindCard
  extend ActiveSupport::Concern

  def find_card
    @card = current_user.cards.find(params[:id] || params[:card_id])
  end
end
