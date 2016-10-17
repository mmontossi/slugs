require 'rails/generators/base'

module Cronjobs
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def create_definitions_file
        copy_file 'configuration.rb', 'config/initializers/slugs.rb'
      end

    end
  end
end
