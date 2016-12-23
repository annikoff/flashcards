# frozen_string_literal: true
class CreateAnalyticsEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :analytics_events do |t|
      t.integer :visit_id

      # user
      t.integer :user_id
      # add t.string :user_type if polymorphic

      t.string :name
      t.json :properties
      t.timestamp :time
    end

    add_index :analytics_events, [:visit_id, :name]
    add_index :analytics_events, [:user_id, :name]
    add_index :analytics_events, [:name, :time]
  end
end
