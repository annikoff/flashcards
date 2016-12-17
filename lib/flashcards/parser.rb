# frozen_string_literal: true
module Flashcards
  class Parser
    attr_accessor :url, :original_text_selector, :translated_text_selector,
                  :redirect_tries

    def initialize(url, original_text_selector, translated_text_selector)
      @url = url
      @original_text_selector = original_text_selector
      @translated_text_selector = translated_text_selector
      @redirect_tries = 3
    end

    # = Parse web page and find texts by given css selectors
    #
    # @example Result:
    #   [
    #     { original_text: 'дом', translated_text: 'house' },
    #     { original_text: 'небо', translated_text: 'sky' }
    #   ]
    # @return [Array]
    def parse
      page = Nokogiri::HTML open(url).read.force_encoding('UTF-8')
      original_texts = page.css(original_text_selector).map(&:text)
      translated_texts = page.css(translated_text_selector).map(&:text)
      original_texts.map.with_index do |original_text, index|
        {
          original_text: original_text,
          translated_text: translated_texts[index]
        }
      end
    end

    private

    def open(url)
      uri = URI.parse url
      tries = redirect_tries
      begin
        uri.open(redirect: false)
      rescue OpenURI::HTTPRedirect => redirect
        uri = redirect.uri
        tries -= 1
        retry if tries.positive?
        raise
      end
    end
  end
end
