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
        include_fields :email, :created_at, :updated_at
      end
      export do
        include_fields :email, :created_at, :updated_at
      end
      edit do
        include_fields :email, :current_block_id,
                       :password, :password_confirmation,
                       :cards, :blocks
      end
    end
  end
end
