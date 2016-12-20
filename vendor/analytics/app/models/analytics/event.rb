# frozen_string_literal: true
module Analytics
  class Event < ApplicationRecord
    include Ahoy::Properties

    self.table_name = 'analytics_events'

    belongs_to :visit, class_name: Analytics::Visit
    belongs_to :user, optional: true
  end
end
