# frozen_string_literal: true
module Dashboard
  class ParsingsController < Dashboard::BaseController
    before_action :find_blocks, only: [:new]

    def new; end

    def create
      ::ParsingJob.perform_later(current_user, parsing_params.to_h)
      redirect_to cards_path,
                  notice: I18n.t('global.notices.parsing_is_running')
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
