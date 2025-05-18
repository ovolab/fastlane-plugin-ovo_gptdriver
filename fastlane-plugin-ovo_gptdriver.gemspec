lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/ovo_gptdriver/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-ovo_gptdriver'
  spec.version       = Fastlane::OvoGptdriver::VERSION
  spec.author        = 'Christian Borsato'
  spec.email         = 'christian@ovolab.com'

  spec.summary       = 'This Fastlane plugin provides actions for interacting with GPT Driver.'
  spec.homepage      = "https://github.com/ovolab/fastlane-plugin-ovo_gptdriver"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.require_paths = ['lib']
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.required_ruby_version = '>= 2.6'

  spec.add_runtime_dependency 'rest-client'
end
