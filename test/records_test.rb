require 'test_helper'

class RecordsTest < ActiveSupport::TestCase
  
  setup do
    @without = Without.create(name: 'name')
    @simple = Simple.create(name: 'name', age: 14)
    @translatable = Translatable.create(name: 'translatable name', age: 20)
  end

  test "should not break validation" do
    assert Without.new.valid?
    assert Simple.new.valid?
    assert Translatable.new.valid?
  end

  test "should not break models" do
    assert_equal 'name', @without.name
    assert_equal @without, Without.find('1')
    assert_equal @without, Without.find(1)
  end

  test "should create slug" do
    assert_equal 'name', @simple.slug
    assert_equal @simple, Simple.find('name')
    assert_equal 'translatable-name', @translatable.slug
    assert_equal @translatable, Translatable.find('translatable-name')
  end

  test "should edit slug" do
    @simple.update_attributes name: 'new name'
    assert_equal 'new-name', @simple.slug
    assert_equal @simple, Simple.find('new-name')
    @translatable.update_attributes name: 'new translatable name'
    assert_equal 'new-translatable-name', @translatable.slug
    assert_equal @translatable, Translatable.find('new-translatable-name')
  end

  test "should not alter direct assigned slug" do
    @simple.update_attributes slug: 'direct slug'
    assert_equal 'direct slug', @simple.slug
    assert_equal @simple, Simple.find('direct slug')
    @translatable.update_attributes slug: 'translatable direct slug'
    assert_equal 'translatable direct slug', @translatable.slug
    assert_equal @translatable, Translatable.find('translatable direct slug')
  end

  test "should assign index for same slugs" do
    first = Simple.create(name: 'same', age: 34)
    assert_equal 'same', first.slug
    second = Simple.create(name: 'same', age: 45)
    assert_equal 'same-1', second.slug
    third = Simple.create(name: 'same', age: 234)
    assert_equal 'same-2', third.slug

    first.update_attributes name: 'other'
    assert_equal 'other', first.slug
    second.update_attributes name: 'other'
    assert_equal 'other-1', second.slug
    third.update_attributes name: 'other'
    assert_equal 'other-2', third.slug

    first = Translatable.create(name: 'same', age: 34)
    assert_equal 'same', first.slug
    second = Translatable.create(name: 'same', age: 45)
    assert_equal 'same-1', second.slug
    third = Translatable.create(name: 'same', age: 234)
    assert_equal 'same-2', third.slug

    first.update_attributes name: 'other'
    assert_equal 'other', first.slug
    second.update_attributes name: 'other'
    assert_equal 'other-1', second.slug
    third.update_attributes name: 'other'
    assert_equal 'other-2', third.slug
  end

end
