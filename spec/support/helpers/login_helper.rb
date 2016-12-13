# frozen_string_literal: true
module LoginHelper
  def login(email, password)
    page.find(:css, 'a.log_in').click
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    page.find(:css, 'input.log_in').click
  end

  def register(email, password, password_confirmation)
    visit new_user_path
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password_confirmation
    page.find(:css, 'input.sing_up').click
  end
end
