module Slugs
  module ActiveRecord
    module Base
      extend ActiveSupport::Concern

      def to_param
        self.class.sluggable? ? (slug_changed? ? slug_was : slug) : super
      end

      protected

      def assign_slug
        if slug.nil? or not slug_changed?
          options = self.class.slug
          case options
          when Symbol      
            value = send(options)
          when Array                     
            value = options.each.map{ |p| send(p) }.join(' ')
          when Proc                       
            value = options.call(self)
          end
          if value.present?
            value = value.parameterize
            previous_value = previous_slug?(value)
            if previous_value != false
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
      end

      module ClassMethods

        def inherited(subclass)
          subclass.instance_variable_set(:@slug, @slug)
          super
        end
        
        def sluggable?
          !defined?(@slug).nil? and @slug.present?
        end
        
        def slug(*args)
          if args.any?
            unless sluggable?
              if respond_to? :translatable? and translatable?
                include Slugs::ActiveRecord::Translatable
                attr_translatable :slug 
                before_validation :generate_slugs
              else
                include Slugs::ActiveRecord::NonTranslatable
                before_validation :generate_slug
              end
              @slug = args.size == 1 ? args[0] : args                              
            end
          end
          @slug
        end
      
      end
    end
  end
end
