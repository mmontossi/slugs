module Slugs
  module ActiveRecord
    module NonTranslatable
      extend ActiveSupport::Concern
      module ClassMethods

        def find_previous_slug(slug)
          where(
            'slug LIKE ? OR slug = ?', "#{slug}-%", slug
          ).order(
            'LENGTH(slug) DESC, slug DESC'
          ).map(&:slug).select{ |r| r =~ /^#{slug}(-\d+)?$/ }.first
        end

        def find_by_slug(id)
          find_by slug: id
        end

        def exists_by_slug?(id)
          exists? slug: id
        end

      end
    end
  end
end
