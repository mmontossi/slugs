module Slugs
  class Railtie < Rails::Railtie

    initializer 'slugs' do
      ::ActiveRecord::Base.send :include, Slugs::ActiveRecord::Base
      ::ActiveRecord::Relation.send :include, Slugs::ActiveRecord::Relation
    end

  end
end
