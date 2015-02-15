module Slugs
  class Railtie < Rails::Railtie

    initializer 'slugs' do
      ::ActiveRecord::Base.send :include, Slugs::ActiveRecord::Base
    end

  end
end
