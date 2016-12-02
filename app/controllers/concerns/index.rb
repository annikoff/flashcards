# frozen_string_literal: true
module Index
  extend ActiveSupport::Concern

  def index
    @card = current_user.first_acceptable_card
    respond_to do |format|
      format.html
      format.js
    end
  end
end
