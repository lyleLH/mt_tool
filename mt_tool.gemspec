# frozen_string_literal: true

require_relative "lib/mt_tool/version"

Gem::Specification.new do |spec|
  spec.name = "mt_tool"
  spec.version = MtTool::VERSION
  spec.authors = ["LyleLH"]
  spec.email = ["v2top1lyle@gmail.com"]
  spec.summary = "常用工具."
  spec.description = "常用工具 -- 快速创建模版代码."
  spec.homepage = "https://github.com/lyleLH/mt_tool"
  spec.required_ruby_version = ">= 2.6.0"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/lyleLH/mt_tool"
  spec.license = "MIT"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir[
    "lib/**/*",
    "bin/*",
    "*.gemspec",
    "README.md",
    "Gemfile",
    "Rakefile"
  ]
  spec.bindir = "bin"
  spec.executables << 'mt_tool'
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency 'thor', '~> 1.2'
  spec.add_dependency 'xcodeproj', '~> 1.22'
  spec.add_dependency 'colored', '~> 1.2'
  spec.add_dependency 'colored2', '~> 3.1'
  spec.add_dependency 'pathname', '~> 0.2'
  spec.add_dependency 'mustache', '~> 1.1'
  spec.add_dependency 'activesupport', '~> 7.0'

  # Development dependencies
  spec.add_development_dependency 'bundler', '~> 2.3'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.12'
  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'pry-byebug', '~> 3.10'
end
