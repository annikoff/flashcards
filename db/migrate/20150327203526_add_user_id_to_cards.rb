# frozen_string_literal: true
class AddUserIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :user_id, :integer
  end
end
