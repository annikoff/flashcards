# frozen_string_literal: true
require 'rails_helper'

describe External::FlickrController, type: :request do
  describe 'photos_search' do
    it 'returns an array of found photos' do
      get photos_search_flickr_index_path,
          params: { text: 'cats', format: 'json' }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)&.size).to eq(10)
    end
  end
end
