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
            'LENGTH(slug) DESC, slug DESC'
          ).pluck('slug').select{ |r| r =~ /^#{slug}(-\d+)?$/ }.first
        end
 
      end
    end
  end
end
