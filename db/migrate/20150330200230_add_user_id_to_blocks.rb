# frozen_string_literal: true
class AddUserIdToBlocks < ActiveRecord::Migration[5.0]
  def change
    add_column :blocks, :user_id, :integer, null: false
  end
end
