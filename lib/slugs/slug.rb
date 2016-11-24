module Slugs
  class Slug < ActiveRecord::Base

    belongs_to :sluggable, polymorphic: true

    validates_presence_of :sluggable, :value

  end
end
