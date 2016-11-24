require 'test_helper'

class RecordsTest < ActiveSupport::TestCase

  test 'finders' do
    user = User.create(first_name: 'Zakk', last_name: 'Wylde')
    assert_equal 'zakk-wylde', user.slug
    assert User.exists?('zakk-wylde')
    assert User.exists?(user.id)
    assert User.exists?(user.id.to_s)
    assert_equal user, User.find('zakk-wylde')
    assert_equal user, User.find(user.id)
    assert_equal user, User.find(user.id.to_s)

    user.update first_name: 'Yngwie', last_name: 'Malmsteen'
    assert_equal 'yngwie-malmsteen', user.slug
    assert User.exists?('zakk-wylde')
    assert_equal user, User.find('zakk-wylde')
    assert User.exists?('yngwie-malmsteen')
    assert_equal user, User.find('yngwie-malmsteen')
    assert_equal user, User.find(user.id)
    assert_equal user, User.find(user.id.to_s)

    user = User.create(first_name: 'Zakk', last_name: 'Wylde')
    assert_equal 'zakk-wylde', user.slug
    assert User.exists?('zakk-wylde')
    assert User.exists?(user.id)
    assert User.exists?(user.id.to_s)
    assert_equal user, User.find('zakk-wylde')
    assert_equal user, User.find(user.id)
    assert_equal user, User.find(user.id.to_s)
  end

  test 'indices' do
    3.times.each do |index|
      shop = Shop.create(name: 'Guitar Shop')
      if index == 0
        assert_equal 'guitar-shop', shop.slug
      else
        assert_equal "guitar-shop-#{index}", shop.slug
      end
    end

    shop = Shop.first
    3.times.each do |index|
      product = Product.create(name: 'Les Paul', shop: shop)
      if index == 0
        assert_equal 'les-paul', product.slug
      else
        assert_equal "les-paul-#{index}", product.slug
      end
    end

    shop = Shop.last
    3.times.each do |index|
      product = Product.create(name: 'Les Paul', shop: shop)
      if index == 0
        assert_equal 'les-paul', product.slug
      else
        assert_equal "les-paul-#{index}", product.slug
      end
    end
  end

end
