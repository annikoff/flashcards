# frozen_string_literal: true
class ChangeLocaleForUsers < ActiveRecord::Migration
  def change
    change_column :users, :locale, :string, null: false, default: ''
  end
end
