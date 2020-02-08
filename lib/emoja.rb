require 'json'
require 'emoja/version'

module Emoja
  Meta = Struct.new(:keywords, :short_name, :group, :subgroup)

  class Dictionary
    def search(emoji)
      if (d = data[emoji])
        Meta.new(d['keywords'], d['short_name'], d['group'], d['subgroup'])
      else
        nil
      end
    end

    def emoji_list
      data.keys
    end

    private

    def data
      @data ||= JSON.load(File.open('lib/data/emoji_ja.json'))
    end
  end

  class << self

    # @param text [String]
    def translate(text)
      text.chars.map do |c|
        meta = dictionary.search(c)
        meta ? meta.short_name : c
      end.join
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
