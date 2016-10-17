module Slugs
  module Extensions
    module ActionDispatch
      module OptimizedUrlHelper

        def parameterize_args(args)
          params = {}
          parameterized_args = args.map do |arg|
            Slugs.parameterize arg, @options
          end
          @required_parts.zip(parameterized_args) do |key, value|
            params[key] = value
          end
          params
        end

      end
    end
  end
end
