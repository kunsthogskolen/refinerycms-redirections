# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("dummy/config/environment", __dir__)
if File.exist?(
  dummy_path = File.expand_path('dummy/config/environment.rb', __dir__)
)
  require dummy_path
elsif File.dirname(__FILE__).match?(%r{vendor/extensions})
  # Require the path to the refinerycms application this is vendored inside.
  require File.expand_path('../../../../config/environment', __dir__)
else
  puts "Could not find a config/environment.rb file to require. " \
       "Please specify this in #{File.expand_path(__FILE__)}"
end

require 'rspec/rails'
require 'capybara/rspec'

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:each) do
    ::I18n.default_locale = I18n.locale = Globalize.locale = :en
  end

  # Avoid repeating FactoryBot
  config.include FactoryBot::Syntax::Methods

  # Store last errors so we can run rspec with --only-failures
  config.example_status_persistence_file_path = ".rspec_failures"
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories including factories.
([Rails.root.to_s] | ::Refinery::Plugins.registered.pathnames).map do |p|
  Dir[File.join(p, 'spec', 'support', '**', '*.rb').to_s]
end.flatten.sort.each do |support_file|
  require support_file
end

def debug
  save_and_open_page
end
