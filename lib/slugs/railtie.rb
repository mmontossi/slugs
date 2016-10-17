module Slugs
  class Railtie < Rails::Railtie

    initializer 'slugs' do
      ::ActionDispatch::Routing::RouteSet::NamedRouteCollection::UrlHelper::OptimizedUrlHelper.prepend(
        Slugs::Extensions::ActionDispatch::OptimizedUrlHelper
      )
      ::ActionDispatch::Routing::RouteSet::Generator.prepend(
        Slugs::Extensions::ActionDispatch::Generator
      )
      ::ActiveRecord::Base.include(
        Slugs::Extensions::ActiveRecord::Base
      )
    end

  end
end
