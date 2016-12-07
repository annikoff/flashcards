# frozen_string_literal: true
require 'rails_helper'

describe 'when user creates card', type: :feature, js: true do
  before do
    create(:user_with_one_block_without_cards)
    visit new_card_path
    login('test@test.com', '12345', 'Войти')
  end

  it 'page has download link' do
    expect(page).to have_link I18n.t('global.actions.download_from_flickr')
  end

  it 'clicks to download link' do
    click_link I18n.t('global.actions.download_from_flickr')
    expect(page).to have_selector 'input[name="flickr_search"]'
    expect(page).to have_button I18n.t('global.actions.find_on_flickr')
  end
end
