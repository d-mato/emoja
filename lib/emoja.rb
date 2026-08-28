# frozen_string_literal: true

require "json"
require "emoja/version"

# Translates emoji into Japanese and looks emoji up by Japanese keyword.
module Emoja
  Meta = Data.define(:emoji, :keywords, :short_name, :group, :subgroup)

  # Indexes the bundled emoji-ja dictionary by emoji and by keyword.
  class Dictionary
    # No dictionary key carries a presentation modifier, so strip them off
    # before looking an emoji up.
    MODIFIERS = /[\u{FE0F}\u{1F3FB}-\u{1F3FF}]/
    private_constant :MODIFIERS

    def find(emoji)
      data[emoji.gsub(MODIFIERS, "")]
    end

    def search(keyword)
      keyword_data[keyword] || []
    end

    def emoji_list
      data.keys
    end

    private

    def data
      @data ||= JSON.parse(File.read(File.join(__dir__, "data", "emoji_ja.json"))).to_h do |emoji, meta|
        [emoji, Meta.new(emoji, meta["keywords"], meta["short_name"], meta["group"], meta["subgroup"])]
      end
    end

    def keyword_data
      return @keyword_data if @keyword_data

      @keyword_data = {}
      data.each_value do |meta|
        meta.keywords.each do |k|
          @keyword_data[k] ||= []
          @keyword_data[k] << meta
        end
      end
      @keyword_data
    end
  end

  class << self
    # @param text [String]
    def translate(text)
      text.grapheme_clusters.map do |g|
        meta = dictionary.find(g)
        meta ? meta.short_name : g
      end.join
    end

    # @param keyword [String]
    def search(keyword)
      dictionary.search(keyword).map(&:emoji)
    end

    # @param text [String]
    def include_emoji?(text)
      text.grapheme_clusters.any? { |g| dictionary.find(g) }
    end

    private

    def dictionary
      @dictionary ||= Dictionary.new
    end
  end
end
