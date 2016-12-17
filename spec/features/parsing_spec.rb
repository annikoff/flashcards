# frozen_string_literal: true
require 'rails_helper'

describe 'parsings' do
  before(:each) do
    @user = create(:user_with_one_block_without_cards)
    @block = @user.blocks.first
    visit root_path
    login('test@test.com', '12345')
  end

  describe 'when visit index path' do
    let(:parsing) { create(:parsing, user: @user, block: @block) }

    it 'sees all parsings' do
      parsing.parse!
      visit parsings_path
      expect(page).to have_css('table.table tbody tr', count: 1)
    end
  end

  describe 'when visit new parsing path' do
    let(:parsing) { build(:parsing, user: @user, block: @block) }

    it 'creates new parsing' do
      visit new_parsing_path
      fill_in 'parsing[url]', with: parsing.url
      select @block.title, from: 'parsing[block_id]'
      fill_in 'parsing[original_text_selector]',
              with: parsing.original_text_selector
      fill_in 'parsing[translated_text_selector]',
              with: parsing.translated_text_selector
      click_button I18n.t('global.actions.save')
      expect(page).to have_content I18n.t('global.notices.parsing_is_running')
      expect(Delayed::Job.count).to eq(1)
    end
  end

  describe 'when parsing is done' do
    let(:parsing) { create(:parsing, user: @user, block: @block) }

    it 'sees cards created by parsing' do
      parsing.parse!
      visit cards_parsing_path(parsing)
      expect(page).to have_css('table.table tbody tr', count: 70)
    end
  end
end
