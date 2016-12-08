module Slugs
  class Railtie < Rails::Railtie

    initializer 'slugs.extensions' do
      ::ActionDispatch::Routing::RouteSet::Generator.prepend(
        Slugs::Extensions::ActionDispatch::Generator
      )
      ::ActionDispatch::Routing::RouteSet::NamedRouteCollection::UrlHelper::OptimizedUrlHelper.prepend(
        Slugs::Extensions::ActionDispatch::OptimizedUrlHelper
      )
      ::ActiveRecord::Base.include(
        Slugs::Extensions::ActiveRecord::Base
      )
      ::ActiveRecord::Base.extend(
        Slugs::Extensions::ActiveRecord::Finders
      )
      ::ActiveRecord::Relation.include(
        Slugs::Extensions::ActiveRecord::Finders
      )
    end

    rake_tasks do
      load 'tasks/slugs.rake'
    end

  end
end
