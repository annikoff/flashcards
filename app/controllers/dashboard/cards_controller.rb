# frozen_string_literal: true
module Dashboard
  class CardsController < Dashboard::BaseController
    include FindCard
    before_action :find_card, only: [:destroy, :edit, :update]
    before_action :find_blocks, only: [:edit, :new]

    def index
      @cards = current_user.cards.all.order('review_date')
    end

    def new
      @card = Card.new
    end

    def edit; end

    def create
      @card = current_user.cards.build(card_params)
      if @card.save
        track_card_create
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
      @card.destroy
      respond_with @card
    end

    private

    def card_params
      params
        .require(:card)
        .permit(:original_text, :translated_text, :review_date, :image,
                :image_cache, :remove_image, :remote_image_url, :block_id)
    end

    def find_blocks
      @blocks = current_user.blocks.all.order('title')
    end

    def track_card_create
      ahoy.track 'card_create', card_id: @card.id
    end
  end
end
