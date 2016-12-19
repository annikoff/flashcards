# frozen_string_literal: true
require 'rails_helper'

describe Flashcards::Parser do
  it 'should parse url and return an array of words' do
    params = {
      url: 'http://example.com/',
      original_text_selector: 'table td:nth-child(2)',
      translated_text_selector: 'table td:nth-child(4)'
    }
    result = Flashcards::Parser.new(params).parse
    expect(result.size).to eq(70)
    expect(result.first)
      .to eq(original_text: 'Mother', translated_text: 'мама')
  end
end
