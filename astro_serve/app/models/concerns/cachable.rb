require 'active_support/concern'

module Cacheable
  extend ActiveSupport::Concern
  included do
    def self.cached_find(uuid)
      Rails.cache.fetch([self.model_name.cache_key, uuid]) {
        puts self
        object = self.find uuid
        # raise Apollo::ResourceGone, "Attempting to access deleted #{object.class} with #{uuid}" if object.deleted
        raise Exception, "Attempting to access deleted #{object.class} with #{uuid}" if object.deleted
        object
      }  
    end

    after_save :flush_cache
    
    def flush_cache
      Rails.cache.delete([self.class.model_name.cache_key, self.uuid])
    end
  end
  
end
