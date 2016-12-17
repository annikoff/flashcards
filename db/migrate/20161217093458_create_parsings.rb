# frozen_string_literal: true
class CreateParsings < ActiveRecord::Migration[5.0]
  def change
    create_table :parsings do |t|
      t.string :url, null: false
      t.string :original_text_selector, null: false
      t.string :translated_text_selector, null: false
      t.integer :user_id, null: false
      t.integer :block_id, null: false
      t.string :error

      t.timestamps
    end
  end
end
