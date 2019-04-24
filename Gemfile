source 'http://rubygems.org'

gemspec

git 'https://github.com/refinery/refinerycms.git', branch: '4-0-stable' do
  gem 'refinerycms'

  group :development, :test do
    gem 'refinerycms-testing'
  end
end

platforms :ruby do
  gem 'sqlite3'
end

group :development, :test do
  gem 'byebug'
  gem 'ffaker'
  gem 'launchy'
  gem 'listen'
  gem 'rubocop'
  platforms :ruby do
    require 'rbconfig'
    if RbConfig::CONFIG['target_os'].match?(/linux/i)
      gem 'therubyracer', '~> 0.11.4'
    end
  end
end

group :test do
  gem 'database_cleaner'
end
