module Slugs
  module Extensions
    module ActiveRecord
      module Finders
        extend ActiveSupport::Concern

        def find(id)
          if sluggable? && id.is_a?(String) && id !~ /\A\d+\z/
            order = Slugs::Slug.order(id: :desc)
            joins(:slugs).merge(order).find_by! slugs: { value: id }
          else
            super
          end
        end

        def exists?(value=:none)
          if sluggable? && value.is_a?(String) && value !~ /\A\d+\z/
            joins(:slugs).exists? slugs: { value: value }
          else
            super
          end
        end

      end
    end
  end
end
