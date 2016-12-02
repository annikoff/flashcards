# frozen_string_literal: true
class Block < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  belongs_to :user

  validates_presence_of :title

  def current?
    id == user.current_block_id
  end
end
