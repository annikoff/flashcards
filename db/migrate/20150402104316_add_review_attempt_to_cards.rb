# frozen_string_literal: true
class AddReviewAttemptToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :review_attempt, :integer, null: false, default: 1
  end
end
