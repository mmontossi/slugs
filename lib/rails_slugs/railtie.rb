module RailsSlugs
  class Railtie < ::Rails::Railtie

    initializer 'rails_slugs' do
      ::ActiveRecord::Relation.send :include, RailsSlugs::ActiveRecord::Relation
      ::ActiveRecord::Base.send :extend, RailsSlugs::ActiveRecord::Base::NonSluggable
    end

  end
end
