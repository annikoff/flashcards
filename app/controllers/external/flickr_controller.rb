# frozen_string_literal: true
module External
  class FlickrController < ApplicationController
    #before_action :require_login
    rescue_from StandardError do |exception|
      p exception
      render json: { error: exception }, status: 500
    end

    def photos_search
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
end
