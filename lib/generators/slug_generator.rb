class SlugGenerator < Rails::Generators::Base
  
  include Rails::Generators::Migration  
  source_root File.expand_path('../templates', __FILE__)
  
  def create_model
    template 'model.rb.erb', 'app/models/slug.rb'
  end
  
  def create_migration
    migration_template 'migration.rb.erb', 'db/migrate/create_slugs.rb'
  end
  
  def self.next_migration_number(path)
    Time.now.utc.strftime('%Y%m%d%H%M%S')
  end  
  
end