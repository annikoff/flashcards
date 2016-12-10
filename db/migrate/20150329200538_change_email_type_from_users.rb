# frozen_string_literal: true
class ChangeEmailTypeFromUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :email, :string, null: true
  end
end
