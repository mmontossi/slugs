module Slugs
  module Extensions
    module ActiveRecord
      module Base
        extend ActiveSupport::Concern

        module ClassMethods

          def has_slug(*args)
            include Slugs::Concern
            options = args.extract_options!
            @slug = options.merge(attributes: args)
          end

        end
      end
    end
  end
end
