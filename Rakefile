# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :clean do
  FileUtils.rm_rf('pkg')
  FileUtils.rm_rf('test_output')
end

task :build => :clean

task :test => [:clean, :spec]

task :default => :test
