# frozen_string_literal: true
class ChangeLocaleDefaultForUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :locale, :string, null: true
  end
end
