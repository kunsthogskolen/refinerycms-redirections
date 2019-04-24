require File.expand_path('lib/refinery/redirections/version', __dir__)

version = Refinery::Redirections::Version
rails_version = ['>= 5.1.0', '< 5.2']

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-redirections'
  s.authors           = ["Peter Kordel"]
  s.version           = version.to_s
  s.description       = 'Ruby on Rails Redirections extension for Refinery CMS'
  s.date              = '2019-04-24'
  s.summary           = 'Redirections extension for Refinery CMS'
  s.homepage          = 'https://github.com/pkordel/refinerycms-redirections'
  s.require_paths     = %w[lib]
  s.files             = Dir['{app,config,db,lib}/**/*'] + ['README.md']
  s.required_ruby_version = version.required_ruby_version

  # Runtime dependencies
  s.add_dependency 'actionpack',   rails_version
  s.add_dependency 'activerecord', rails_version
  s.add_dependency 'railties',     rails_version

  s.add_dependency 'acts_as_indexed', '~> 0.8.0'
  s.add_dependency 'enumerize'
  s.add_dependency 'rack-rewrite'
  s.add_dependency 'refinerycms-core', '~> 4.0.3'
  s.add_dependency 'refinerycms-i18n'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 4.0.3'
end
