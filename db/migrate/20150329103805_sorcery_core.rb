# frozen_string_literal: true
class SorceryCore < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :email, :string, null: false
    rename_column :users, :password, :crypted_password
    add_column :users, :salt, :string

    add_index :users, :email, unique: true
  end
end
