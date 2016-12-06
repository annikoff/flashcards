# frozen_string_literal: true
class Block < ApplicationRecord
  has_many :cards, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  include BlockAdmin

  def current?
    id == user.current_block_id
  end
end
