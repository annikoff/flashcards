# frozen_string_literal: true
module Dashboard
  class TrainerController < Dashboard::BaseController
    include FindCard
    before_action :find_card, only: [:review_card]

    def index
      @card = current_user.first_acceptable_card
      respond_to do |format|
        format.html
        format.js
      end
    end

    def review_card
      check_result = @card.check_translation(trainer_params[:user_translation])

      if check_result[:state]
        if check_result[:distance].zero?
          flash[:notice] = t('global.notices.correct_translation')
        else
          flash[:alert] = t 'global.alerts.translation_from_misprint',
                            user_translation: trainer_params[:user_translation],
                            original_text: @card.original_text,
                            translated_text: @card.translated_text
        end
        redirect_to trainer_path
      else
        flash[:alert] = t('global.alerts.incorrect_translation')
        redirect_to trainer_path(id: @card.id)
      end
    end

    private

    def trainer_params
      params.permit(:user_translation)
    end
  end
end
