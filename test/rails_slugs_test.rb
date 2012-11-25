require 'test_helper'

class RailsSlugsTest < ActiveSupport::TestCase
  
  setup :create_records

  test 'truth' do
    assert_kind_of Module, RailsSlugs
  end

  test 'shoud create slug' do
    assert_equal @simple.slug, 'name'
    assert_equal @translatable.slug, 'translatable-name'
  end

  test 'should edit slug' do
    @simple.update_attributes :name => 'new name'
    assert_equal @simple.slug, 'new-name'
    @translatable.update_attributes :name => 'new translatable name'
    assert_equal @translatable.slug, 'new-translatable-name'
  end

  test 'should not alter direct assigned slug' do
    @simple.update_attributes :slug => 'direct slug'
    assert_equal @simple.slug, 'direct slug'
    @translatable.update_attributes :slug => 'translatable direct slug'
    assert_equal @translatable.slug, 'translatable direct slug'
  end

  protected

  def create_records
    @simple = Simple.create(:name => 'name', :age => 14)
    @translatable = Translatable.create(:name => 'translatable name', :age => 20)
  end

end
