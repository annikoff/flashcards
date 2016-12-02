# frozen_string_literal: true
class Authentication < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :provider, :uid
end
