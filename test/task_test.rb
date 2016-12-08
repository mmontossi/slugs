require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  setup do
    Dummy::Application.load_tasks
  end

  test 'import' do
    shop = Shop.create(name: 'Guitar shop')
    category = Category.create(name: 'Electric', shop: shop)
    Slugs::Slug.destroy_all
    Rake::Task['slugs:migrate'].invoke
    assert_equal %w(guitar-shop electric), Slugs::Slug.pluck(:value)
  end

end
