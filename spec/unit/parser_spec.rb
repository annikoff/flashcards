# frozen_string_literal: true
require 'rails_helper'

describe Flashcards::Parser do
  it 'should parse url and return an array of words' do
    parser = Flashcards::Parser.new 'http://example.com/',
                                    'table td:nth-child(2)',
                                    'table td:nth-child(4)'
    result = parser.parse
    expect(result.size).to eq(70)
    expect(result.first)
      .to eq(original_text: 'Mother', translated_text: 'мама')
  end
end
