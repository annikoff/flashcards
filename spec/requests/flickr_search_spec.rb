# frozen_string_literal: true
require 'rails_helper'

describe 'FlickrSearch' do
  describe 'index' do
    it 'returns an array of found photos' do
      get flickr_search_index_path,
          params: { text: 'cats', format: 'json' }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)&.size).to eq(10)
    end
  end
end
