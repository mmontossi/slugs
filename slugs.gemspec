$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'slugs/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'slugs'
  s.version     = Slugs::VERSION
  s.authors     = ['Mattways']
  s.email       = ['contact@mattways.com']
  s.homepage    = 'https://github.com/mattways/slugs'
  s.summary     = 'Slugs for Rails.'
  s.description = 'Inspired in friendly_id but more minimalistic.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', (ENV['RAILS_VERSION'] ? "~> #{ENV['RAILS_VERSION']}" : '>= 3.0.0')

  if RUBY_PLATFORM == 'java'
    s.add_development_dependency 'activerecord-jdbcsqlite3-adapter'
    s.add_development_dependency 'jruby-openssl'
  else
    s.add_development_dependency 'sqlite3'
  end
end
