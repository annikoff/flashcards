# frozen_string_literal: true
module Welcome
  extend ActiveSupport::Concern

  def index
    if params[:id]
      @card = find_card params[:id]
    elsif current_user.current_block
      @card = current_user.current_block.cards.pending.first
      @card ||= current_user.current_block.cards.repeating.first
    else
      @card = current_user.cards.pending.first
      @card ||= current_user.cards.repeating.first
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
