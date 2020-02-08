require 'json'
require 'emoja/version'

module Emoja
  Meta = Struct.new(:emoji, :keywords, :short_name, :group, :subgroup)

  class Dictionary
    def find(emoji)
      data[emoji]
    end

    def search(keyword)
      keyword_data[keyword] || []
    end

    def emoji_list
      data.keys
    end

    private

    def data
      @data ||= JSON.load(File.open('lib/data/emoji_ja.json')).map do |emoji, meta|
        [emoji, Meta.new(emoji, meta['keywords'], meta['short_name'], meta['group'], meta['subgroup'])]
      end.to_h
    end

    def keyword_data
      return @keyword_data if @keyword_data
      @keyword_data = {}
      data.each do |emoji, meta|
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
      text.chars.map do |c|
        meta = dictionary.find(c)
        meta ? meta.short_name : c
      end.join
    end

    # @param keyword [String]
    def search(keyword)
      dictionary.search(keyword).map(&:emoji)
    end

    # @param text [String]
    def include_emoji?(text)
      !(text.chars & dictionary.emoji_list).empty?
    end

    private

    def dictionary
      @dictionary ||= Dictionary.new
    end
  end
end
