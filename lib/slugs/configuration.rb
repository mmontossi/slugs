module Slugs
  class Configuration

    def use_slug?(*args, &block)
      if block_given?
        @use_slug = block
      else
        if @use_slug
          @use_slug.call *args
        else
          false
        end
      end
    end

  end
end
