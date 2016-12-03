# frozen_string_literal: true
class ChangeLocaleDefaultFalseForUsers < ActiveRecord::Migration
  def change
    change_column :users, :locale, :string, default: nil
  end
end
