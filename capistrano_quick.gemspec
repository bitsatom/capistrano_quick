# frozen_string_literal: true

require_relative "lib/capistrano_quick/version"

Gem::Specification.new do |spec|
  spec.name          = "capistrano_quick"
  spec.version       = CapistranoQuick::VERSION
  spec.authors       = ["Pavan Agrawal"]
  spec.email         = ["pavan.agrawala@gmail.com"]

  spec.summary       = "Deploying Rails with Capistrano & Puma on AWS EC2"
  spec.description   = "Capistrano is a powerful deployment automation tool for Ruby on Rails applications. In this guide, we’ll set up Capistrano with Puma on an AWS EC2 instance to deploy a Rails application smoothly."
  spec.homepage      = "https://github.com/bitsatom/capistrano_quick"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/bitsatom/capistrano_quick"
  spec.metadata["changelog_uri"] = "https://github.com/bitsatom/capistrano_quick"

  # Ensure only necessary files are included
  spec.files = Dir["lib/**/*", "exe/*", "README.md"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
end
