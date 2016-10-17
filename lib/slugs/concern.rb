module Slugs
  module Concern
    extend ActiveSupport::Concern

    included do
      before_create :set_slug
      after_save :ensure_slug_uniqueness
      validates_format_of :slug, with: /\A[a-z0-9\-]+\z/, allow_blank: true
      validates_length_of :slug, maximum: 255, allow_blank: true
    end

    def sluggable?
      self.class.sluggable?
    end

    private

    def set_slug
      options = self.class.slug
      self.slug = slice(*options[:attributes]).values.join(' ').parameterize
    end

    def ensure_slug_uniqueness
      options = self.class.slug
      case options[:scope]
      when Symbol
        attribute = options[:scope]
        scope = { attribute => send(attribute) }
      when Array
        attributes = options[:scope]
        scope = attributes.map{ |attribute| [attribute, send(attribute)] }.to_h
      end
      if self.class.where(scope).where(slug: slug).where.not(id: id).any?
        update_column :slug, "#{slug}-#{id}"
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
