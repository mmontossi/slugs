module RailsSlugs
  class Railtie < ::Rails::Railtie

    initializer 'rails_slugs' do
      ::ActiveRecord::Relation.send :include, RailsSlugs::ActiveRecord::Relation
      ::ActiveRecord::Base.send :include, RailsSlugs::ActiveRecord::Base
    end

  end
end
