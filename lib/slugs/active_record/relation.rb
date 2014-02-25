module Slugs
  module ActiveRecord
    module Relation
      extend ActiveSupport::Concern

      def find_one(id)
        (sluggable? and id.is_a? String) ? (find_by_slug(id) || super) : super
      end

      def exists?(id=false)
        (sluggable? and id.is_a? String) ? (exists_by_slug(id) || super) : super
      end

    end
  end
end
