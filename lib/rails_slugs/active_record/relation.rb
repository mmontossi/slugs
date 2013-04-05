module RailsSlugs
  module ActiveRecord
    module Relation

      def find_one(id)
        r = (sluggable? and id.is_a? String) ? find_by_slug(id) : nil
        r.nil? ? super : r
      end

      def exists?(id = false)
        r = (sluggable? and id.is_a? String) ? exists_by_slug(id) : nil
        r.nil? ? super : r
      end

    end
  end
end
