# frozen_string_literal: true
module Dashboard
  class ParsingsController < Dashboard::BaseController
    before_action :find_parsing, only: [:destroy, :cards]
    before_action :find_blocks, only: [:new]

    def index
      @parsings = current_user.parsings.includes(:cards)
    end

    def new
      @parsing = current_user.parsings.new
    end

    def create
      @parsing = current_user.parsings.build(parsing_params)
      if @parsing.save && ::ParsingJob.perform_later(@parsing)
        redirect_to parsings_path,
                    notice: I18n.t('global.notices.parsing_is_running')
      else
        respond_with @parsing
      end
    end

    def cards
      @cards = @parsing.cards
    end

    def destroy
      @parsing.destroy
      respond_with @parsing
    end

    private

    def parsing_params
      params
        .require(:parsing)
        .permit(:url, :block_id,
                :original_text_selector, :translated_text_selector)
    end

    def find_parsing
      @parsing = current_user.parsings.find(params[:id] || params[:parsing_id])
    end

    def find_blocks
      @blocks = current_user.blocks.all.order('title')
    end
  end
end
