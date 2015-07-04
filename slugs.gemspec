$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'slugs/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'slugs'
  s.version     = Slugs::VERSION
  s.authors     = ['Museways']
  s.email       = ['contact@museways.com']
  s.homepage    = 'https://github.com/museways/slugs'
  s.summary     = 'Slugs for rails.'
  s.description = 'Minimalistic slugs inspired in friendly_id for rails.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'rails', (ENV['RAILS_VERSION'] ? "~> #{ENV['RAILS_VERSION']}" : ['>= 4.0.0', '< 4.3.0'])

  s.add_development_dependency 'translatable_records', '~> 1.1', '>= 1.1.4'

  if RUBY_PLATFORM == 'java'
    s.add_development_dependency 'activerecord-jdbcsqlite3-adapter', '~> 1.3'
    s.add_development_dependency 'jruby-openssl', '~> 0.9'
  else
    s.add_development_dependency 'sqlite3', '~> 1.3'
  end
end
