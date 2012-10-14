module RailsSlugs
  module ActiveRecord
    module NonSluggableMethods
      
      def sluggable?
        not defined?(@slug).nil?
      end      
      
      def slug(*args)
        unless args.empty?
          unless sluggable?     
            include RailsSlugs::ActiveRecord::SluggableMethods
            if respond_to? :translatable? and translatable?   
              include RailsSlugs::ActiveRecord::I18nMethods 
              before_validation :generate_slugs   
              validate :slug, :uniquess => true, :scope => :locale                    
            else    
              include RailsSlugs::ActiveRecord::NonI18nMethods               
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
        self.slug
      end   
      
    end     
    module I18nMethods
      
      def self.included(base)
        base.instance_eval do
          
          def find_by_slug(id)
            includes(:translations).where(:translations => {:slug => id, :locale => I18n.locale}).first
          end
          
          def exists_by_slug(id)
            joins(:translations).exists?(:translations => {:slug => id, :locale => I18n.locale})
          end
                    
        end
      end
      
      protected
      
      def generate_slugs
        options = self.class.slug     
        locale = current_locale
        I18n.available_locales.each do |locale|
          I18n.locale = locale    
          with_locale locale   
          case options
          when Symbol      
            self.slug = send(options).parameterize
          when Array                     
            self.slug = options.each.map{|p|send(p)}.join(' ').parameterize     
          when Proc                       
            self.slug = options.call(self).parameterize
          end
        end
        I18n.locale = locale
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
          options = self.class.slug
          case options
          when Symbol      
            self.slug = send(options).parameterize
          when Array                     
            self.slug = options.each.map{|p|send(p)}.join(' ').parameterize     
          when Proc                       
            self.slug = options.call(self).parameterize
          end     
        end
      end
      
    end      
  end
end

ActiveRecord::Base.send :extend, RailsSlugs::ActiveRecord::NonSluggableMethods
