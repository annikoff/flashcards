# frozen_string_literal: true
module Home
  class HomeController < Home::BaseController
    include CardFinder, Welcome
  end
end
