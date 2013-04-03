require 'test_helper'

class RailsSlugsTest < ActiveSupport::TestCase
  
  test 'truth' do
    assert_kind_of Module, Rails::Slugs
  end

end
