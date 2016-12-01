# frozen_string_literal: true
class AddCurrentBlockToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_block, :integer, null: true
  end
end
