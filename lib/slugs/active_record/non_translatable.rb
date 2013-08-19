module Slugs
  module ActiveRecord 
    module NonTranslatable
      extend ActiveSupport::Concern

      protected
      
      def previous_slug?(slug)
        r = self.class.where(
          "(slug = '#{slug}' OR slug LIKE '#{slug}-_')"
        ).order(
          'slug DESC'
        ).first
        r.respond_to?(:slug) ? (r == self ? false : r.slug) : nil
      end

      def generate_slug
        assign_slug
      end

      module ClassMethods

        def exists_by_slug(id)
          exists? slug: id
        end
    
      end
    end
  end
end
