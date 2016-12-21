# frozen_string_literal: true
module Analytics
  class ChartsController < ApplicationController
    def index
    end

    def visits
      render json: Analytics::Visit.all
    end

    def events
      render json: Analytics::Event.all
    end
  end
end
