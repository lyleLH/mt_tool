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

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'thor'
  spec.add_development_dependency 'colored'
  spec.add_development_dependency 'colored2'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'xcodeproj'
  spec.add_development_dependency 'cocoapods'
  spec.add_development_dependency 'cocoapods-core'

  spec.add_dependency 'bundler'
  spec.add_dependency 'thor'
  spec.add_dependency 'xcodeproj'
  spec.add_dependency 'colored'
  spec.add_dependency 'pathname'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
