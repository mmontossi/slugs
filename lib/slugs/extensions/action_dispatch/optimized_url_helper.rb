module Slugs
  module Extensions
    module ActionDispatch
      module OptimizedUrlHelper
        extend ActiveSupport::Concern

        private

        def parameterize_args(args)
          parameterized_args = args.map do |arg|
            Slugs.parameterize arg, @options
          end
          params = {}
          @required_parts.zip(parameterized_args) { |k,v| params[k] = v }
          params
        end

      end
    end
  end
end
