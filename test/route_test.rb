require 'test_helper'

class RouteTest < ActionDispatch::IntegrationTest

  setup do
    @shop = Shop.create(name: 'Guitar Shop')
  end

  test 'generator' do
    assert_equal '/shops/guitar-shop?page=3', shop_path(@shop, page: 3)
  end

  test 'optimized url helper' do
    assert_equal '/shops/guitar-shop', shop_path(@shop)
  end

end
