require 'test_helper'

class ModelTest < ActiveSupport::TestCase

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

    domain = Domain.create
    assert_nothing_raised do
      Domain.find domain.id
      Domain.exists? domain.id+1
    end
  end

  test 'indices' do
    3.times.each do |index|
      shop = Shop.create(name: 'Guitar Shop')
      slug = 'guitar-shop'
      if index != 0
        slug << "-#{index}"
      end
      assert_equal slug, shop.slug
    end

    shop = Shop.first
    3.times.each do |index|
      product = Product.create(name: 'Les Paul', shop: shop)
      slug = 'les-paul'
      if index != 0
        slug << "-#{index}"
      end
      assert_equal slug, product.slug
    end

    shop = Shop.last
    3.times.each do |index|
      product = Product.create(name: 'Les Paul', shop: shop)
      slug = 'les-paul'
      if index != 0
        slug << "-#{index}"
      end
      assert_equal slug, product.slug
    end
  end

end
