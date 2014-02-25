module Slugs
  module ActiveRecord 
    module NonTranslatable
      extend ActiveSupport::Concern

      module ClassMethods

        def exists_by_slug(id)
          exists? slug: id
        end
 
        def find_previous_slug(slug)
          where(
            "slug LIKE '#{slug}-%' OR slug = '#{slug}'"
          ).order(
            'slug DESC'
          ).select{ |r| r.slug =~ /^#{slug}(-\d+)?$/ }.first.try(:slug)
        end
 
      end
    end
  end
end
