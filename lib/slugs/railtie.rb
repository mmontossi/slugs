module Slugs
  class Railtie < Rails::Railtie

    initializer 'slugs' do
      ::ActiveRecord::Relation.send :include, Slugs::ActiveRecord::Relation
      ::ActiveRecord::Base.send :include, Slugs::ActiveRecord::Base
    end

  end
end
