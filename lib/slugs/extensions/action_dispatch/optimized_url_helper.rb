module Slugs
  module Extensions
    module ActionDispatch
      module OptimizedUrlHelper

        def parameterize_args(args)
          parameterized_args = args.map do |arg|
            Slugs.parameterize arg, @options
          end
          if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 2
            params = {}
            @required_parts.zip(parameterized_args) { |k,v| params[k] = v }
            params
          else
            @required_parts.zip parameterized_args
          end
        end

      end
    end
  end
end
