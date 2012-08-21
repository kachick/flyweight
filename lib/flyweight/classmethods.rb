module Flyweight

  module ClassMethods

    def intern(*values)
      if (pool = _pool).has_key? values
        pool[values]
      else
        pool[values] = new(*values)
      end
    end

    alias_method :value_for, :intern
    
    def flush
      Flyweight.flush_pool! self
    end
    
    private
    
    def inherited(klass)
      Flyweight.prepare_pool! klass
    end
    
    def _pool
      if singleton_class.const_defined? POOL_NAME, false
        singleton_class.const_get POOL_NAME
      else
        Flyweight.prepare_pool! self
      end
    end
  
  end

end
