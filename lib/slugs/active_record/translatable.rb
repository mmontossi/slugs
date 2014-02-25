module Slugs
  module ActiveRecord 
    module Translatable
      extend ActiveSupport::Concern
 
      protected

      def generate_slugs
        old_locale = current_locale
        I18n.available_locales.each do |locale|
          I18n.locale = locale
          with_locale locale
          generate_slug
        end
        I18n.locale = old_locale
        with_locale old_locale
      end

      module ClassMethods

        def find_previous_slug(slug)
          t = reflect_on_association(:translations)
          joins(
            "INNER JOIN #{t.table_name} t ON t.#{t.foreign_key} = #{table_name}.#{t.active_record_primary_key}"
          ).where(
            "(t.slug LIKE '#{slug}-%' OR t.slug = '#{slug}') AND t.locale = '#{I18n.locale}'"
          ).order(
            't.slug DESC'
          ).first.try(:slug)
        end

        def find_by_slug(id)
          t = reflect_on_association(:translations)
          joins(
            "INNER JOIN #{t.table_name} t ON t.#{t.foreign_key} = #{table_name}.#{t.active_record_primary_key}"
          ).where(
            "t.slug = '#{id}' AND t.locale = '#{I18n.locale}'"
          ).readonly(false).first
        end
 
        def exists_by_slug(id)
          t = reflect_on_association(:translations)
          joins(:translations).exists? t.table_name.to_sym => { slug: id, locale: I18n.locale }
        end

      end      
    end
  end
end
