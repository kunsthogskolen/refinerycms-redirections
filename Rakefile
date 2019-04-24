#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

ENGINE_PATH = File.dirname(__FILE__)
APP_RAKEFILE = File.expand_path("spec/dummy/Rakefile", __dir__)

load 'rails/tasks/engine.rake' if File.exists? APP_RAKEFILE

require "refinerycms-testing"
Refinery::Testing::Railtie.load_dummy_tasks ENGINE_PATH

load File.expand_path('tasks/testing.rake', __dir__)
load File.expand_path('tasks/rspec.rake', __dir__)
