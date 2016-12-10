# frozen_string_literal: true
module BlockAdmin
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        include_fields :title, :created_at, :updated_at, :user
      end
      show do
        include_fields :title, :user
      end
      export do
        include_fields :title, :created_at, :updated_at, :user, :cards
      end
      edit do
        include_fields :title, :user, :cards
      end
    end
  end
end
