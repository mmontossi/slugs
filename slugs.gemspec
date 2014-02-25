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
  s.summary     = 'Slugs for Rails.'
  s.description = 'Inspired in friendly_id but more minimalistic.'
  s.license     = 'MIT'

  s.post_install_message = 'REMEMBER TO RENAME "slug" TO "has_slug" IN YOUR MODELS'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', (ENV['RAILS_VERSION'] ? "~> #{ENV['RAILS_VERSION']}" : '>= 3.0.0')
  
  s.add_development_dependency 'translatable_records'

  if RUBY_PLATFORM == 'java'
    s.add_development_dependency 'activerecord-jdbcsqlite3-adapter'
    s.add_development_dependency 'jruby-openssl'
  else
    s.add_development_dependency 'sqlite3'
  end
end
