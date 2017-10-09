$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'slugs/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'slugs'
  s.version     = Slugs::VERSION
  s.authors     = ['mmontossi']
  s.email       = ['hi@museways.com']
  s.homepage    = 'https://github.com/museways/slugs'
  s.summary     = 'Slugs for rails.'
  s.description = 'Manages slugs for records with minimal efford in rails.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.1'

  s.add_development_dependency 'pg', '~> 0.21'
end
