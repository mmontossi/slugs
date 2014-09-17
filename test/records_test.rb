require 'test_helper'

class RecordsTest < ActiveSupport::TestCase

  test 'not break validation' do
    assert Without.new.valid?
    assert Simple.new.valid?
    assert Translatable.new.valid?
  end

  test 'not break models' do
    assert_equal 'name', without.name
    assert_equal without, Without.find('1')
    assert_equal without, Without.find(1)
  end

  test 'create slug' do
    assert_equal 'name', simple.slug
    assert_equal simple, Simple.find('name')

    assert_equal 'translatable-name', translatable.slug
    assert_equal translatable, Translatable.find('translatable-name')
  end

  test 'update slug' do
    simple.name = 'new name'
    simple.save!
    assert_equal 'new-name', simple.slug
    assert_equal simple, Simple.find('new-name')

    translatable.name = 'new translatable name'
    translatable.save!
    assert_equal 'new-translatable-name', translatable.slug
    assert_equal translatable, Translatable.find('new-translatable-name')
  end

  test 'not alter direct assigned slug' do
    simple.slug = 'direct slug'
    simple.save!
    assert_equal 'direct slug', simple.slug
    assert_equal simple, Simple.find('direct slug')

    translatable.slug = 'translatable direct slug'
    translatable.save!
    assert_equal 'translatable direct slug', translatable.slug
    assert_equal translatable, Translatable.find('translatable direct slug')
  end

  test 'records not be readonly' do
    Simple.create! name: 'editable'
    assert !Simple.find('editable').readonly?

    Translatable.create! name: 'editable'
    assert !Translatable.find('editable').readonly?
  end

  test 'assign index for same slugs' do
    first = Simple.create!(name: 'same', age: 34)
    assert_equal 'same', first.slug

    Simple.create!(name: 'same-larger', age: 10)
    20.times { Simple.create!(name: 'same', age: 10) }

    second = Simple.create!(name: 'same', age: 45)
    assert_equal 'same-21', second.slug
    third = Simple.create!(name: 'same', age: 234)
    assert_equal 'same-22', third.slug

    first.name = 'same'
    first.save!
    assert_equal 'same', first.slug
    second.name = 'same'
    second.save!
    assert_equal 'same-23', second.slug
    third.name = 'other'
    third.save!
    assert_equal 'other', third.slug

    first = Translatable.create!(name: 'same', age: 34)
    assert_equal 'same', first.slug

    Translatable.create!(name: 'same-larger', age: 10)
    20.times { Translatable.create!(name: 'same', age: 10) }

    second = Translatable.create!(name: 'same', age: 45)
    assert_equal 'same-21', second.slug
    third = Translatable.create!(name: 'same', age: 234)
    assert_equal 'same-22', third.slug

    first.name = 'same'
    first.save!
    assert_equal 'same', first.slug
    second.name = 'same'
    second.save!
    assert_equal 'same-23', second.slug
    third.name = 'other'
    third.save!
    assert_equal 'other', third.slug
  end

  private

  def simple
    @simple ||= Simple.create!(name: 'name', age: 14)
  end

  def without
    @without ||= Without.create!(name: 'name')
  end

  def translatable
    @translatable ||= Translatable.create!(name: 'translatable name', age: 20)
  end

end
