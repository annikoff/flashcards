# frozen_string_literal: true
class CardsMailer < ActionMailer::Base
  default from: ENV['DEFAULT_EMAIL_FROM_CARDS']

  def pending_cards_notification(email)
    mail(to: email, subject: t('cards_mailer.cards_created_by_parsing.heading'))
  end

  def cards_created_by_parsing(email, cards)
    @cards = cards
    mail(to: email, subject: t('cards_mailer.cards_created_by_parsing.heading'))
  end
end
