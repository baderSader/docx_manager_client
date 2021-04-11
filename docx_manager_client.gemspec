# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'docx_manager_client/version'

Gem::Specification.new do |s|
  s.name          = "docx_manager_client"
  s.version       = DocxManagerClient::VERSION
  s.authors       = ["Bader Sader"]
  s.email         = ["bader.bahjat@gmail.com"]

  s.homepage      = 'https://github.com/baderSader/docx_manager_client'
  s.summary       = 'a rails client for the project DocxManagerServer'
  s.description   = 'a client for the porject DocxManagerServer that server docx into pdf and png ..etc please check:{{URL}}'
  s.platform      = Gem::Platform::RUBY
  s.license       = 'MIT'

  s.files         = `git ls-files lib init.rb docx_manager_client.gemspec`.split($INPUT_RECORD_SEPARATOR)
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.4.0'

  s.add_runtime_dependency 'activemodel', '>= 5'
  s.add_runtime_dependency 'faraday_middleware', '~> 1.0.0'
  s.add_runtime_dependency 'hashie', '~> 4.1', '>= 4.0.0'
end
