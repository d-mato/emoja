# frozen_string_literal: true

require "net/http"

namespace :data do
  desc "Fetch emoji dictionaries"
  task :fetch do
    base_uri = URI("https://raw.githubusercontent.com/yagays/emoji-ja/master/data/")
    [
      "emoji_ja.json"
      # 'group2emoji_ja.json',
      # 'keyword2emoji_ja.json',
    ].each do |file|
      File.write("lib/data/#{file}", Net::HTTP.get(base_uri + file))
    end
  end
end
