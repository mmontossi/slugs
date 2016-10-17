module Slugs
  module Extensions
    module ActionDispatch
      module Generator

        def generate
          if Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 2
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
          else
            @set.formatter.generate(
              :path_info,
              named_route,
              options,
              recall,
              lambda do |name, value|
                if name == :controller
                  value
                elsif value.is_a?(Array)
                  value.map{ |v| Slugs.parameterize v, options }.join('/')
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
end
