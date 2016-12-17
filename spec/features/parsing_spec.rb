# frozen_string_literal: true
require 'rails_helper'

describe 'when visit new parsing path' do
  before(:each) do
    @user = create(:user_with_one_block_without_cards)
    @block = @user.blocks.first
    visit new_parsing_path
    login('test@test.com', '12345')
  end

  it 'creates new parsing' do
    fill_in 'url', with: 'http://example.com/'
    select @block.title, from: 'block_id'
    fill_in 'original_text_selector', with: 'table td:nth-child(2)'
    fill_in 'translated_text_selector', with: 'table td:nth-child(4)'
    click_button I18n.t('global.actions.parse')
    expect(page).to have_content I18n.t('global.notices.parsing_is_running')
    expect(Delayed::Job.count).to eq(1)
  end
end
