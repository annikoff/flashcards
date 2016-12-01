# frozen_string_literal: true
class Home::HomeController < Home::BaseController
  include CardFinder, Welcome
end
