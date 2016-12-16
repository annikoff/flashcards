# frozen_string_literal: true
require 'rails_helper'

describe 'when user creates parsing' do
  before do
    @user = create(:user_with_one_block_without_cards)
    visit new_parsing_path
    login('test@test.com', '12345')
  end

  it 'fills in form' do
    block = @user.blocks.first
    fill_in 'url', with: 'http://example.com/'
    select block.title, from: 'block_id'
    fill_in 'original_text_selector', with: '.original_text'
    fill_in 'translated_text_selector', with: '.translated_text'
    click_button I18n.t('global.actions.parse')
  end
end
