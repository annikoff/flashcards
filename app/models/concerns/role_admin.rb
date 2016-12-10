# frozen_string_literal: true
module RoleAdmin
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        include_fields :name, :created_at
      end
      show do
        include_fields :name, :users
      end
      export do
        include_fields :name, :created_at, :users
      end
      edit do
        include_fields :name, :users
      end
    end
  end
end
