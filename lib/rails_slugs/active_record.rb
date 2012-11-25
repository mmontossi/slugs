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
              attr_translatable :slug 
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
        slug
      end   

      protected

      def assign_slug
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
    module I18nMethods
      
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

      def generate_slugs
        locale = current_locale
        I18n.available_locales.each do |locale|
          change_locale locale
          assign_slug
        end
        change_locale locale
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
        assign_slug
      end
      
    end      
  end
end

ActiveRecord::Base.send :extend, RailsSlugs::ActiveRecord::NonSluggableMethods
