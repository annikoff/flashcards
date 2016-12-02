# frozen_string_literal: true
module Dashboard
  class CardsController < Dashboard::BaseController
    include FindCard
    before_action :find_card, only: [:destroy, :edit, :update]

    def index
      @cards = current_user.cards.all.order('review_date')
    end

    def new
      @card = Card.new
    end

    def edit; end

    def create
      raise ActiveRecord::RecordNotFound if @card.blank?
      @card = current_user.cards.build(card_params)
      if @card.save
        redirect_to cards_path
      else
        respond_with @card
      end
    end

    def update
      if @card.update(card_params)
        redirect_to cards_path
      else
        respond_with @card
      end
    end

    def destroy
      raise ActiveRecord::RecordNotFound if @card.blank?
      @card.destroy
      respond_with @card
    end

    private

    def card_params
      params
        .require(:card)
        .permit(:original_text, :translated_text, :review_date,
                :image, :image_cache, :remove_image, :block_id)
    end
  end
end
