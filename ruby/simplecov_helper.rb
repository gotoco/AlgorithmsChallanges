# spec/simplecov_helper.rb
require 'simplecov'

if ENV['JOB_NAME'] # on ci server
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
else
  require 'simplecov-html'
  SimpleCov::Formatter::HTMLFormatter
end

# Make sure coverage/ directory is always created in root even we run tests/specs
# from another directory (via RubyMine).
SimpleCov.root(File.expand_path("../../", __FILE__))
SimpleCov.start 'rails'