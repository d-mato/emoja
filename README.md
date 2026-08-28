# Emoja

Translate emoji into Japanese, and look emoji up by Japanese keyword.

## Installation

```sh
bundle add emoja
```

## Usage

```ruby
Emoja.translate("🍎食べたい")
# => "赤リンゴ食べたい"

Emoja.translate("🐈‍⬛が好き")
# => "黒猫が好き"

Emoja.search("猫")
# => ["😺", "😸", "😹", "😻", "😼", "😽", "🙀", "😿", "😾", "🐱", "🐈", "🐈‍⬛", "🐾"]

Emoja.include_emoji?("🍎")
# => true
```

An emoji the dictionary does not know is left untouched by `translate`.

## Notice

[emoji_ja.json](https://github.com/d-mato/emoja/blob/master/lib/data/emoji_ja.json) in this project is provided by [emoji-ja](https://github.com/yagays/emoji-ja).
