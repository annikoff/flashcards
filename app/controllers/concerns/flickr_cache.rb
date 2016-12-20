# frozen_string_literal: true
module FlickrCache
  extend ActiveSupport::Concern

  private

  def photos_search(text)
    Rails.cache.fetch(text, expires_in: expires_in) do
      flickr.photos.search(text: text, per_page: 10)
    end
  end

  def photo_info(photo)
    Rails.cache.fetch(photo, expires_in: expires_in) do
      info = flickr.photos.getInfo(photo_id: photo.id)
      { title: info.title, url: FlickRaw.url_m(info) }
    end
  end

  def expires_in
    6.hours
  end
end
