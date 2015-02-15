[![Gem Version](https://badge.fury.io/rb/slugs.svg)](http://badge.fury.io/rb/slugs) [![Code Climate](https://codeclimate.com/github/museways/slugs/badges/gpa.svg)](https://codeclimate.com/github/museways/slugs) [![Build Status](https://travis-ci.org/museways/slugs.svg?branch=master)](https://travis-ci.org/museways/slugs) [![Dependency Status](https://gemnasium.com/museways/slugs.svg)](https://gemnasium.com/museways/slugs)

# Slugs

Minimalistic slugs inspired in friendly_id for rails.

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

Add the slug column to the tables of the models you want to have slugs:
```ruby
t.string :slug
```

Update your db:
```
rake db:migrate
```

NOTE: If you are using translatable_records you need to place the column in the translations table.

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

If you need a very custom slug you can use a lambda, proc or block:
```ruby
has_slug proc { |record| "#{record.prop}-custom" }
```

To find a record by slug:
```ruby
Model.find_by_slug 'slug'
```

NOTE: All the path and url helpers will start using the slug by default.

## Credits

This gem is maintained and funded by [museways](http://museways.com).

## License

It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
