# frozen_string_literal: true
class ChangeEmailTypeFromUsers < ActiveRecord::Migration
  def change
    change_column :users, :email, :string, null: true
  end
end
