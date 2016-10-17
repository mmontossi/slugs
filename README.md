[![Gem Version](https://badge.fury.io/rb/slugs.svg)](http://badge.fury.io/rb/slugs)
[![Code Climate](https://codeclimate.com/github/mmontossi/slugs/badges/gpa.svg)](https://codeclimate.com/github/mmontossi/slugs)
[![Build Status](https://travis-ci.org/mmontossi/slugs.svg)](https://travis-ci.org/mmontossis/slugs)
[![Dependency Status](https://gemnasium.com/mmontossi/slugs.svg)](https://gemnasium.com/mmontossi/slugs)

# Slugs

Manages slugs for records with minimal efford in rails.

## Install

Put this line in your Gemfile:
```ruby
gem 'slugs'
```

Then bundle:
```
$ bundle
```

## Configuration

Generate the slugs configuration file:
```
bundle exec rails g slugs:install
```

Add the slug column to the tables of the models you want to have slugs:
```ruby
t.string :slug
```

Update your db:
```
bundle exec rake db:migrate
```

Configure the proc to decide which records will be slugged:
```ruby
Slugs.configure do |config|
  config.use_slug_proc = Proc.new do |record, params|
    params[:controller] != 'admin'
  end
end
```

## Usage

Use has_slug in your models to define what the slug will be:

If you want to use the value of one field:
```ruby
has_slug :prop
```

To concatenate the value of multiple fields:
```ruby
has_slug :prop1, :prop2, :prop3
```

To find a record by slug:
```ruby
Model.find_by slug: 'slug'
```

## Credits

This gem is maintained and funded by [mmontossi](https://github.com/mmontossi).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
