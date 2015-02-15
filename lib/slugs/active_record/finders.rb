module Slugs
  module ActiveRecord
    module Finders
      extend ActiveSupport::Concern
      module ClassMethods

        def slugged
          all.extending do

            def find(*args)
              find_by_slug args.first
            end

            def exists?(*args)
              exists_by_slug? args.first
            end

          end
        end

      end
    end
  end
end
