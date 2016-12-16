# frozen_string_literal: true
module Dashboard
  class ParsingController < Dashboard::BaseController
    before_action :find_blocks, only: [:new, :create]

    def index
    end

    def new; end

    def create
      ParsingJob.perfom_later
      redirect_to :index, I18n.t('')
    end

    private

    def parsing_params
      params.permit(:url, :block_id,
                    :original_text_selector, :translated_text_selector)
    end

    def find_blocks
      @blocks = current_user.blocks.all.order('title')
    end
  end
end
