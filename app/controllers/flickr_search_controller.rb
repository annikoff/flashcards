# frozen_string_literal: true
class FlickrSearchController < ApplicationController
  include FlickrCache

  rescue_from StandardError do |exception|
    render json: { error: exception }, status: 500
  end

  def index
    @photos = photos_search(flickr_params[:text]).map { |photo| photo_info photo }
  end

  private

  def flickr_params
    params.permit(:text)
  end
end
