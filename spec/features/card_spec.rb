# frozen_string_literal: true
require 'rails_helper'

describe 'when user creates card', js: true do
  before do
    user = create(:user_with_one_block_and_one_card)
    @card = user.cards.first
    visit edit_card_path id: @card.id
    login('test@test.com', '12345')
  end

  it 'page has download link' do
    expect(page).to have_link I18n.t('global.actions.download_from_flickr')
  end

  it 'clicks to download link' do
    click_link I18n.t('global.actions.download_from_flickr')
    expect(page).to have_field 'flickr_search'
    expect(page).to have_button I18n.t('global.actions.find_on_flickr')
  end

  it 'finds Flickr images by search query, selects any image and save card' do
    click_link I18n.t('global.actions.download_from_flickr')
    fill_in 'flickr_search', with: 'cats'
    click_button I18n.t('global.actions.find_on_flickr')
    wait_for_ajax
    expect(page).to have_css('.thumbnail', count: 10)
    page.all(:css, '.thumbnail')[rand(0..9)].click
    click_button I18n.t('global.actions.save')
    visit edit_card_path id: @card.id
    expect(page).to have_css('p.thumbnail img', count: 1)
  end
end
