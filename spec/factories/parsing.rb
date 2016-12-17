# frozen_string_literal: true
FactoryGirl.define do
  factory :parsing do
    url 'http://example.com'
    original_text_selector '.post-full table td:nth-child(2)'
    translated_text_selector '.post-full table td:nth-child(4)'
    user
    block
  end
end
