require 'test_helper'

class RecordsTest < ActiveSupport::TestCase

  test 'save' do
    user = User.create(first_name: 'Zakk', last_name: 'Wylde')
    assert_equal 'zakk-wylde', user.slug

    user.update slug: 'yngwie-malmsteen'
    assert_equal 'yngwie-malmsteen', user.slug
  end

  test 'uniqueness' do
    2.times { Shop.create(name: 'Guitar Shop') }
    shop = Shop.last
    assert_equal "guitar-shop-#{shop.id}", shop.slug

    2.times { Category.create(name: 'Gibson', shop: shop) }
    category = Category.last
    assert_equal "gibson-#{category.id}", category.slug

    2.times { Product.create(name: 'Les Paul', shop: shop, category: category) }
    product = Product.last
    assert_equal "les-paul-#{product.id}", product.slug
  end

end
