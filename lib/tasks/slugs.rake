namespace :slugs do
  desc 'Import slugs.'
  task migrate: :environment do
    Slugs.migrate
  end
end
