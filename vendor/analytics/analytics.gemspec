$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'analytics/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'analytics'
  s.version     = Analytics::VERSION
  s.authors     = ['annikoff']
  s.email       = ['annikoff@ya.ru']
  s.homepage    = 'https://github.com/annikoff/flashcards'
  s.summary     = 'Analytics for rails application'
  s.description = 'Analytics for rails application'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  #s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"

  s.add_dependency 'ahoy_matey'
end
