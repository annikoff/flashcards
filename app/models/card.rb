# frozen_string_literal: true
require 'super_memo'

class Card < ApplicationRecord
  belongs_to :user
  belongs_to :block
  before_validation :set_review_date_as_now, on: :create
  validate :texts_are_not_equal
  validates :original_text, :translated_text, :review_date, presence: true
  validates :user_id, :block_id, presence: true
  validates :interval, :repeat, :efactor, :quality, :attempt, presence: true

  mount_uploader :image, CardImageUploader
  include CardAdmin

  scope :pending, lambda {
    where('review_date <= ?', Time.current).order('RANDOM()')
  }
  scope :repeating, -> { where('quality < ?', 4).order('RANDOM()') }

  def check_translation(user_translation)
    distance = Levenshtein.distance(full_downcase(translated_text),
                                    full_downcase(user_translation))
    options = {
      interval: interval,
      repeat: repeat,
      efactor: efactor,
      attempt: attempt,
      distance: distance,
      distance_limit: 1
    }
    sm_hash = SuperMemo.algorithm options

    if distance <= 1
      sm_hash[:review_date] = Time.current + interval.to_i.days
      sm_hash[:attempt] = 1
      update(sm_hash)
      { state: true, distance: distance }
    else
      sm_hash[:attempt] = [attempt + 1, 5].min
      update(sm_hash)
      { state: false, distance: distance }
    end
  end

  def self.pending_cards_notification
    users = User.where.not(email: nil)
    users.each do |user|
      if user.cards.pending.any?
        CardsMailer.pending_cards_notification(user.email).deliver_later
      end
    end
  end

  protected

  def set_review_date_as_now
    self.review_date = Time.current
  end

  def texts_are_not_equal
    return if original_text.blank? || translated_text.blank?
    return if full_downcase(original_text) != full_downcase(translated_text)
    errors.add :original_text, :input_values_must_be_different
  end

  def full_downcase(str)
    str.mb_chars.downcase.to_s.squeeze(' ').lstrip
  end
end
