# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'
require 'yard'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.options = '-v'
  t.warning = false
  t.test_files = FileList['test/**/*_test.rb']
end

RuboCop::RakeTask.new :rubocop do |t|
  t.options = ['--display-cop-names']
end

RuboCop::RakeTask.new :rubocop_autofix do |t|
  t.options = %w[--display-cop-names --auto-correct-all]
end

YARD::Rake::YardocTask.new :yard
