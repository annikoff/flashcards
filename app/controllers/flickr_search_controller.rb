# frozen_string_literal: true
class FlickrSearchController < ApplicationController
  rescue_from StandardError do |exception|
    render json: { error: exception }, status: 500
  end

  def index
    results = flickr.photos.search(text: flickr_params[:text], per_page: 10)
    @photos = results.map do |photo|
      info = flickr.photos.getInfo(photo_id: photo.id)
      { title: info.title, url: FlickRaw.url_m(info) }
    end
  end

  private

  def flickr_params
    params.permit(:text)
  end
end
