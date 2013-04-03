module Rails
  module Slugs
    class Railtie < ::Rails::Railtie

      initializer 'slugs.methods' do
        ActiveRecord::Relation.send :include, Rails::Slugs::Relation
        ActiveRecord::Base.send :extend, Rails::Slugs::Base::NonSluggable
      end

    end
  end
end
