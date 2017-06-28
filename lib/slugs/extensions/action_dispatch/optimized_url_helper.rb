module Slugs
  module Extensions
    module ActionDispatch
      module OptimizedUrlHelper
        extend ActiveSupport::Concern

        def parameterize_args(args)
          params = {}
          @arg_size.times { |i|
            key = @required_parts[i]
            value = Slugs.parameterize(args[i], @options)
            yield key if value.nil? || value.empty?
            params[key] = value
          }
          params
        end

      end
    end
  end
end
