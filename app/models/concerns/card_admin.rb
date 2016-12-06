# frozen_string_literal: true
module CardAdmin
  extend ActiveSupport::Concern

  included do
    rails_admin do
      list do
        include_fields :original_text, :translated_text, :user, :review_date,
                       :created_at, :updated_at
      end
      show do
        include_fields :original_text, :translated_text,
                       :user, :review_date, :image
      end
      export do
        include_fields :original_text, :translated_text, :user, :review_date,
                       :created_at, :updated_at, :image
      end
      edit do
        include_fields :original_text, :translated_text, :user, :review_date,
                       :created_at, :updated_at, :image
      end
    end
  end
end
