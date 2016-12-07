# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

exit if Rails.env.production?

require 'nokogiri'
require 'open-uri'

admin = User.create(email: 'admin@example.com',
                    password: 'admin',
                    password_confirmation: 'admin')
admin.add_role :admin

user = User.create(email: 'user1@example.com',
                   password: '12345',
                   password_confirmation: '12345')
deck = Block.create(title: 'Deck 1', user_id: user.id)

doc = Nokogiri::HTML(open('https://www.learnathome.ru/blog/100-beautiful-words'))
doc.search('//table/tbody/tr').each do |row|
  original = row.search('td[2]')[0].content.downcase
  translated = row.search('td[4]')[0].content.downcase
  Card.create(original_text: original,
              translated_text: translated,
              user_id: user.id,
              block_id: deck.id)
end
