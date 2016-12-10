# frozen_string_literal: true
require 'rails_helper'

describe 'password authentication' do
  describe 'register' do
    before do
      visit root_path
    end

    it 'register TRUE' do
      register('test@test.com', '12345', '12345')
      expect(page).to have_content 'Пользователь успешно создан.'
    end

    it 'password confirmation FALSE' do
      register('test@test.com', '12345', '56789')
      expect(page).to have_content 'Значения не совпадают.'
    end

    it 'e-mail FALSE' do
      register('test', '12345', '12345')
      expect(page).to have_content 'Не верный формат.'
    end

    it 'e-mail has already been taken' do
      register('test@test.com', '12345', '12345')
      click_link 'Выйти'
      register('test@test.com', '12345', '12345')
      expect(page).to have_content 'Не уникальное значение.'
    end

    it 'password is too short' do
      register('test@test.com', '1', '12345')
      expect(page).to have_content 'Короткое значение.'
    end

    it 'password_confirmation is too short' do
      register('test@test.com', '12345', '1')
      expect(page).to have_content 'Значения не совпадают.'
    end
  end

  describe 'authentication' do
    before do
      create(:user)
      visit root_path
    end

    it 'require_login root' do
      expect(page).to have_content 'Добро пожаловать.'
    end

    it 'authentication TRUE' do
      login('test@test.com', '12345')
      expect(page).to have_content 'Вход выполнен успешно.'
    end

    it 'incorrect e-mail' do
      login('1@1.com', '12345')
      expect(page)
        .to have_content 'Вход не выполнен. Проверте вводимые E-mail и Пароль.'
    end

    it 'incorrect password' do
      login('test@test.com', '56789')
      expect(page)
        .to have_content 'Вход не выполнен. Проверте вводимые E-mail и Пароль.'
    end

    it 'incorrect e-mail and password' do
      login('1@1.com', '56789')
      expect(page)
        .to have_content 'Вход не выполнен. Проверте вводимые E-mail и Пароль.'
    end
  end

  describe 'change language' do
    before do
      visit root_path
    end

    it 'home page' do
      click_link 'en'
      expect(page).to have_content 'Welcome.'
    end

    it 'register TRUE' do
      click_link 'en'
      register('test@test.com', '12345', '12345')
      expect(page).to have_content 'User created successfully.'
    end

    it 'default locale' do
      click_link 'en'
      register('test@test.com', '12345', '12345')
      user = User.find_by email: 'test@test.com'
      expect(user.locale).to eq('en')
    end

    it 'available locale' do
      click_link 'en'
      register('test@test.com', '12345', '12345')
      click_link 'Edit profile'
      fill_in 'user[password]', with: '12345'
      fill_in 'user[password_confirmation]', with: '12345'
      click_button I18n.t('global.actions.save')
      expect(page).to have_content 'User profile successfully updated.'
    end

    it 'authentication TRUE' do
      create(:user)
      click_link 'en'
      login('test@test.com', '12345')
      expect(page).to have_content 'Login is successful.'
    end
  end
end
