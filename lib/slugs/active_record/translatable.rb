module Slugs
  module ActiveRecord 
    module Translatable
      extend ActiveSupport::Concern
    
      protected

      def change_locale(locale)
        I18n.locale = locale
        with_locale locale
      end

      def previous_slug?(slug)
        t = self.class.reflect_on_association(:translations)
        r = self.class.joins(
          "INNER JOIN #{t.table_name} t ON t.#{t.foreign_key} = #{self.class.table_name}.#{t.active_record_primary_key}"
        ).where(
          "(t.slug = '#{slug}' OR t.slug LIKE '#{slug}-_') AND t.locale = '#{I18n.locale.to_s}'"
        ).order(
          't.slug DESC'
        ).first
        r.respond_to?(:slug) ? (r == self ? false : r.slug) : nil
      end

      def generate_slugs
        locale = current_locale
        I18n.available_locales.each do |locale|
          change_locale locale
          assign_slug
        end
        change_locale locale
      end

      module ClassMethods

        def find_by_slug(id)
          t = reflect_on_association(:translations)
          joins(
            "INNER JOIN #{t.table_name} t ON t.#{t.foreign_key} = #{table_name}.#{t.active_record_primary_key}"
          ).where(
            "t.slug = '#{id}' AND t.locale = '#{I18n.locale.to_s}'"
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
