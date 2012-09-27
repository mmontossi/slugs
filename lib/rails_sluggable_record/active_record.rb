module RailsSluggableRecord
  module ActiveRecord
    module NonSluggableMethods
      
      def sluggable?
        defined? @slug
      end      
      
      def slug(*args)
        unless args.empty?
          unless sluggable?     
            include RailsSluggableRecord::ActiveRecord::SluggableMethods
            if respond_to? :translatable? and translatable?   
              include RailsSluggableRecord::ActiveRecord::I18nMethods    
              has_many :slugs, :autosave => true, :dependent => :destroy, :as => :sluggable                          
              before_validation :generate_slugs                      
            else    
              include RailsSluggableRecord::ActiveRecord::NonI18nMethods               
              before_validation :generate_slug       
              validate :slug, :uniquess => true                   
            end                                
          end
          @slug = args.size == 1 ? args[0] : args
        end
        @slug
      end    
    
    end   
    module SluggableMethods
      
      def self.included(base)
        ::ActiveRecord::Relation.class_eval do
       
          def find_one(id)
            (id.is_a?(String) and id.to_i != id) ? find_by_slug(id) : super  
          end   

          def exists?(id = false)
            (id.is_a?(String) and id.to_i != id) ? exists_by_slug(id) : super
          end       
          
        end
      end
      
      def to_param
        slug
      end   
      
    end     
    module I18nMethods
      
      def self.included(base)
        base.instance_eval do
          
          def find_by_slug(id)
            includes(:slugs).where(:slugs => {:param => id, :locale => I18n.locale}).first
          end
          
          def exists_by_slug(id)
            joins(:slugs).exists?(:slugs => {:param => id, :locale => I18n.locale})
          end
                    
        end
      end
      
      def slug
        s = slug_by_locale(current_locale)
        s ? s.send(:param) : nil       
      end
      
      def slug=(value)
        s = slug_by_locale(current_locale)
        s ? s.send(:param=, value) : slugs.build(:locale => current_locale, :param => value)      
      end
      
      protected
      
      def slug_by_locale(locale)
        s = slugs.find { |s| s.locale == locale.to_s }
        s ? s : slugs.find_by_locale(locale)
      end
      
      def slug_value
        option = self.class.slug
        case option
        when Symbol        
          param = proc { send(option) }
        when Array        
          param = proc { option.each.map{|p|send(p)}.join(' ') }      
        when Proc            
          param = proc { option.call(self) }
        end        
        param.call.parameterize
      end
      
      def generate_slugs
        locale = current_locale
        I18n.available_locales.each do |locale|
          with_locale locale       
          current_slug = slugs.find{|s| s.locale==locale.to_s}
          current_slug = slugs.find_by_locale(locale) unless current_slug
          if current_slug
            current_slug.param = slug_value
          else
            slugs.build(:param => slug_value, :locale => locale.to_s)
          end
        end
        with_locale locale
      end
      
    end  
    module NonI18nMethods
      
      def self.included(base)
        base.instance_eval do      
      
          def exists_by_slug(id)
            exists? :slug => id
          end  
           
        end
      end
      
      protected   
      
      def generate_slug
        if slug.nil? or not slug_changed?
          option = self.class.slug
          case option
          when Symbol      
            self.slug = send(option).parameterize
          when Array                     
            self.slug = option.each.map{|p|send(p)}.join(' ').parameterize     
          when Proc                       
            self.slug = option.call(self).parameterize
          end     
        end
      end
      
    end      
  end
end

ActiveRecord::Base.send :extend, RailsSluggableRecord::ActiveRecord::NonSluggableMethods
