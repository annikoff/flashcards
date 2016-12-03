# frozen_string_literal: true
module Home
  class HomeController < Home::BaseController
    def index
      @card = current_user.first_acceptable_card
    end
  end
end
