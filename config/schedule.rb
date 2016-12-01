# frozen_string_literal: true
every :day, at: '11:00 am' do
  runner 'Card.pending_cards_notification'
end
