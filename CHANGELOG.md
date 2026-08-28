# Changelog

## Unreleased

### Fixed

- `translate` and `include_emoji?` match emoji by grapheme cluster, so multi
  codepoint emoji such as `🐈‍⬛` and `🇯🇵` are recognized instead of being split
  apart. Variation selectors and skin tone modifiers are stripped before the
  dictionary lookup.

## 0.2.0 - 2026-05-06

### Changed

- Updated the emoji dictionaries from `yagays/emoji-ja`, adding entries such as
  `🐈‍⬛`.

## 0.1.2 - 2026-05-06

### Changed

- Dropped `bundler` from the development dependencies and raised the `rake`
  requirement to `~> 13.0`.

## 0.1.1 - 2020-02-10

### Fixed

- Load the dictionary relative to the gem rather than the working directory, so
  it resolves when the gem is installed.

## 0.1.0 - 2020-02-08

- Initial release.
