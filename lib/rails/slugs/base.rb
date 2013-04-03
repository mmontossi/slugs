module Rails
  module Slugs
    module Base
      module NonSluggable
        
        def sluggable?
          not defined?(@slug).nil?
        end
        
        def slug(*args)
          if args.any?
            unless sluggable?
              include Rails::Slugs::Base::Sluggable
              if respond_to? :translatable? and translatable?
                include Rails::Slugs::I18n::Translatable
                attr_translatable :slug 
                before_validation :generate_slugs
              else
                include Rails::Slugs::I18n::NonTranslatable
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
    end
  end
end
