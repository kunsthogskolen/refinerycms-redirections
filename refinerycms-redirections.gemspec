Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-redirections'
  s.authors           = 'david.brenes@the-cocktail.com'
  s.version           = '3.0.0'
  s.description       = 'RefineryCMS plugin for managing HTTP redirections'
  s.date              = '2013-08-27'
  s.homepage          = 'https://github.com/simplelogica/refinerycms-redirections'
  s.summary           = 'RefineryCMS plugin for managing HTTP redirections'
  s.require_paths     = %w[lib]
  s.files             = Dir['{app,config,db,lib}/**/*'] + ['README.md']

  # Runtime dependencies
  s.add_dependency 'refinerycms-core', '~> 3.0.0'
  s.add_dependency 'refinerycms-i18n', '~> 3.0.0'
  s.add_dependency 'rack-rewrite',     '~> 1.5.1'
  s.add_dependency 'enumerize',        '~> 0.7.0'
end
