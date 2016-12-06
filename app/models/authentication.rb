# frozen_string_literal: true
class Authentication < ApplicationRecord
  belongs_to :user
  validates :user_id, :provider, :uid, presence: true
end
