module RailsSlugs
  module ActiveRecord
    module Base
      module NonSluggable
        
        def sluggable?
          not defined?(@slug).nil?
        end
        
        def slug(*args)
          if args.any?
            unless sluggable?
              include RailsSlugs::ActiveRecord::Base::Sluggable
              if respond_to? :translatable? and translatable?
                include RailsSlugs::ActiveRecord::Base::Translatable
                attr_translatable :slug 
                before_validation :generate_slugs
              else
                include RailsSlugs::ActiveRecord::Base::NonTranslatable
                before_validation :generate_slug
              end
              @slug = args.size == 1 ? args[0] : args                              
            end
          end
          @slug
        end    
      
      end
      module Sluggable
        
        def to_param
          slug
        end

        protected

        def assign_slug
          if slug.nil? or not slug_changed?
            options = self.class.slug
            case options
            when Symbol      
              value = send(options).parameterize
            when Array                     
              value = options.each.map{|p|send(p)}.join(' ').parameterize     
            when Proc                       
              value = options.call(self).parameterize
            end
            previous_value = previous_slug?(value)
            if previous_value.present?
              index = Regexp.new(value + '-(\d+)$').match(previous_value)
              if index.present?
                value << "-#{index[1].to_i + 1}"
              else
                value << '-1'
              end
            end
            self.slug = value
          end
        end

      end
      module NonTranslatable

        def self.included(base)
          base.instance_eval do
        
            def exists_by_slug(id)
              exists? :slug => id
            end

          end
        end
        
        protected
        
        def previous_slug?(slug)
          r = self.class.where(
            (new_record? ? '' : "id != #{id} AND ") + "(slug = '#{slug}' OR slug LIKE '#{slug}-_')"
          ).order(
            'slug DESC'
          ).first
          r.respond_to?(:slug) ? r.slug : nil
        end

        def generate_slug
          assign_slug
        end

      end
      module Translatable
      
        def self.included(base)
          base.instance_eval do
            
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
              joins(:translations).exists?(t.table_name.to_sym => {:slug => id, :locale => I18n.locale})
            end
                      
          end
        end
        
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
            (new_record? ? '' : "#{self.class.table_name}.id != #{id} AND ") + "(t.slug = '#{slug}' OR t.slug LIKE '#{slug}-_') AND t.locale = '#{I18n.locale.to_s}'"
          ).order(
            't.slug DESC'
          ).first
          r.respond_to?(:slug) ? r.slug : nil
        end

        def generate_slugs
          locale = current_locale
          I18n.available_locales.each do |locale|
            change_locale locale
            assign_slug
          end
          change_locale locale
        end
      
      end
    end
  end
end
