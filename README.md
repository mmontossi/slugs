[![Gem Version](https://badge.fury.io/rb/slugs.svg)](http://badge.fury.io/rb/slugs)
[![Code Climate](https://codeclimate.com/github/mmontossi/slugs/badges/gpa.svg)](https://codeclimate.com/github/mmontossi/slugs)
[![Build Status](https://travis-ci.org/mmontossi/slugs.svg)](https://travis-ci.org/mmontossi/slugs)
[![Dependency Status](https://gemnasium.com/mmontossi/slugs.svg)](https://gemnasium.com/mmontossi/slugs)

# Slugs

Manages slugs for records with minimal efford in rails.

## Why

I did this gem to:

- Generalize how to control when routes will use the slug param.
- Keep old slugs active until the record is destroyed.
- Ensure unique slugs by appending an index automatically on duplicates.

## Install

Put this line in your Gemfile:
```ruby
gem 'slugs'
```

Then bundle:
```
$ bundle
```

## Usage

### Configuration

Run the install generator:
```
$ bundle exec rails g slugs:install
```

Set the global settings:
```ruby
Slugs.configure do |config|
  config.use_slug? do |record, params|
    params[:controller] != 'admin'
  end
end
```

### Definition

Add the column to your tables:
```ruby
class AddSlug < ActiveRecord::Migration
  def change
    add_column :products, :slug, :string
  end
end
```

Update your db:
```
$ bundle exec rake db:migrate
```

Define slugs in your models:
```ruby
class Product < ActiveRecord::Base
  has_slug :model, :name, scope: :shop_id
end
```

### Creation

A slug will be generated every time you create/update a record:
```ruby
product = Product.create(name: 'Stratocaster', model: 'American Standar', ...)
product.slug # => 'american-standard-stratocaster'
```

An index will be appended if another record with the same slug is created:
```ruby
product = Product.create(name: 'Stratocaster', model: 'American Standard', ...)
product.slug # => 'american-standard-stratocaster-1'
```

Every time you change a record, the slug will be updated:
```ruby
product.update name: 'Strat'
product.slug # => 'american-standard-strat'
```

### Finders

Finders will start accepting slugs and remember old ones:
```ruby
Product.find 'american-standard-stratocaster' # => product
Product.find 'american-standard-strat' # => product
```

### Routes

In routes use_slug? block will be use to determine when to sluggize:
```ruby
admin_product_path product # => 'admin/products/34443'
product_path product # => 'products/american-standard-strat'
```

## Credits

This gem is maintained and funded by [mmontossi](https://github.com/mmontossi).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
