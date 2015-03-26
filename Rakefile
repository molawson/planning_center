require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

task default: [:spec, :rubocop]

task :console do
  require 'pry'
  require 'planning_center'
  require './spec/support/env'

  ARGV.clear
  Pry.start
end
