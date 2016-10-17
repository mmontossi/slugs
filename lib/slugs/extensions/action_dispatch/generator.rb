module Slugs
  module Extensions
    module ActionDispatch
      module Generator

        def generate
          @set.formatter.generate(
            named_route,
            options,
            recall,
            lambda do |name, value|
              if name == :controller
                value
              else
                Slugs.parameterize value, options
              end
            end
          )
        end

      end
    end
  end
end
