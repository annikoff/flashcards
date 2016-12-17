# frozen_string_literal: true
class CreateParsingCards < ActiveRecord::Migration[5.0]
  def change
    create_table :parsing_cards, id: false do |t|
      t.integer :parsing_id, null: false
      t.integer :card_id, null: false
    end
  end
end
