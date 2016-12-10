# frozen_string_literal: true
module UserAdmin
  extend ActiveSupport::Concern

  included do
    rails_admin do
      configure :password
      configure :password_confirmation

      list do
        include_fields :email, :created_at, :updated_at
      end
      show do
        include_fields :email
      end
      export do
        include_fields :email, :created_at, :updated_at, :roles
      end
      edit do
        include_fields :email, :password, :password_confirmation,
                       :cards, :blocks, :roles
      end
    end
  end
end
