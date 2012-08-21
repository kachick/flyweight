module Flyweight

  class << self

    def prepare_pool!(mod)
      mod.singleton_class.const_set POOL_NAME, {}
    end

    def flush_pool!(mod)
      mod.singleton_class.const_get(POOL_NAME).clear
    end

    private
    
    def included(mod)
      mod.extend ClassMethods
      prepare_pool! mod
    end
  
  end

end
