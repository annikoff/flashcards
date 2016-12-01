# frozen_string_literal: true
class ChangeLocaleDefaultForUsers < ActiveRecord::Migration
  def change
    change_column :users, :locale, :string, null: true
  end
end
