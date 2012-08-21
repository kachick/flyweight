module Flyweight

  module ClassMethods

    # @return [Flyweight] new instance
    def intern(*values)
      if _pool.has_key? values
        _pool.fetch values
      else
        _pool[values] = new(*values)
      end
    end

    alias_method :value_for, :intern

    # @return [Hash]
    def pool
      @_pool.dup
    end
  
    # @return [Hash]
    def flush_pool
      @_pool.clear
    end

    alias_method :flush, :flush_pool
    
    protected

    def replace_pool
      @_pool = {}
    end

    private
    
    def inherited(klass)
      klass.replace_pool
    end
    
    def _pool
      @_pool ||= {}
    end
  
  end

end
