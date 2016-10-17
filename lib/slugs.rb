require 'slugs/extensions/action_dispatch/generator'
require 'slugs/extensions/action_dispatch/optimized_url_helper'
require 'slugs/extensions/active_record/base'
require 'slugs/concern'
require 'slugs/configuration'
require 'slugs/railtie'

module Slugs
  class << self

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

    def parameterize(record, params)
      if use_slug_for?(record, params)
        if record.slug_changed?
          record.slug_was
        else
          record.slug
        end
      else
        record.to_param
      end
    end

    def use_slug_for?(record, params)
      if record.try(:sluggable?) && configuration.use_slug_proc
        configuration.use_slug_proc.call record, params
      else
        false
      end
    end

  end
end
