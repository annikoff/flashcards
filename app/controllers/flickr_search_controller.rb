# frozen_string_literal: true
class FlickrSearchController < ApplicationController
  include FlickrCache
  after_action :track_photos_search

  rescue_from StandardError do |exception|
    render json: { error: exception }, status: 500
  end

  def index
    @photos = photos_search(flickr_params[:text]).map { |p| photo_info p }
  end

  private

  def flickr_params
    params.permit(:text)
  end

  def track_photos_search
    ahoy.track 'photos_search', text: flickr_params[:text]
  end
end
