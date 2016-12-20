# frozen_string_literal: true
module Analytics
  class Visit < ApplicationRecord
    has_many :ahoy_events, class_name: Analytics::Event
    belongs_to :user, optional: true
  end
end
