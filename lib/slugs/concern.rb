module Slugs
  module Concern
    extend ActiveSupport::Concern

    included do
      has_many :slugs, as: :sluggable, class_name: 'Slugs::Slug'
      before_save :set_slug
      validates_format_of :slug, with: /\A[a-z0-9\-]+\z/, allow_blank: true
    end

    def sluggable?
      self.class.sluggable?
    end

    private

    def set_slug
      options = self.class.slug
      self.slug = slice(*options[:attributes]).values.join(' ').parameterize
      case options[:scope]
      when Symbol
        attribute = options[:scope]
        scope = { attribute => send(attribute) }
      when Array
        attributes = options[:scope]
        scope = attributes.map{ |a| [a, send(a)] }.to_h
      end
      relation = self.class.where(scope).where('slug ~ ?', "^#{slug}(-[0-9]+)?$")
      if persisted?
        relation = relation.where.not(id: id)
      end
      previous_slug = relation.order(slug: :desc).limit(1).pluck(:slug).first
      if previous_slug.present?
        if result = previous_slug.match(/^#{slug}-(\d+)$/)
          self.slug += "-#{result[1].to_i + 1}"
        else
          self.slug += '-1'
        end
      end
      if slug_changed?
        slugs.build value: slug
      end
    end

    module ClassMethods

      def slug
        @slug ||= {}
      end

      def sluggable?
        slug.present?
      end

    end
  end
end
