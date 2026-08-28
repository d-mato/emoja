# frozen_string_literal: true

require_relative "lib/emoja/version"

Gem::Specification.new do |spec|
  spec.name          = "emoja"
  spec.version       = Emoja::VERSION
  spec.authors       = ["Daiki Matoba"]
  spec.email         = ["telnetstat@gmail.com"]

  spec.summary       = "Translate emoji into Japanese and look emoji up by Japanese keyword"
  spec.description   = "Emoja replaces the emoji in a string with their Japanese names, and " \
                       "looks emoji up by Japanese keyword, using the emoji-ja dictionary."
  spec.homepage      = "https://github.com/d-mato/emoja"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 3.3"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) || f.start_with?(*%w[bin/ spec/ .github/ .gitignore .rspec Gemfile])
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
