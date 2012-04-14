# flyweight
#   A tiny template for the "Flyweight Pattern"

# Copyright (C) 2012  Kenichi Kamiya

# @example
#   class Material
#     include Flyweight
#
#     def initialize(looks, price)
#       @looks, @price = looks, price
#     end
#   end
#
#   a = Material.intern :metal, 2000
#   b = Material.intern :metal, 2000
#   c = Material.new    :metal, 2000
#   d = Material.intern :paper, 50
#   a == b     #=> true
#   a.equal? b #=> true
#   a == c     #=> true
#   a.equal? c #=> false
#   a == d     #=> false
#   a.equal? d #=> false
module Flyweight
  VERSION = '0.0.3'.freeze
  POOL_NAME = :FLYWEIGHT_POOL
  
  module Eigen
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

  class << self
    def prepare_pool!(mod)
      mod.singleton_class.const_set POOL_NAME, {}
    end

    def flush_pool!(mod)
      mod.singleton_class.const_get(POOL_NAME).clear
    end

    private
    
    def included(mod)
      mod.extend Eigen
      prepare_pool! mod
    end
  end

  def eql?(other)
    self.class == other.class &&
      _comparable.__send__(__callee__, other._comparable)
  end
  
  alias_method :==, :eql?
  
  def hash
    _comparable.inject(0){|sum, val|val.hash ^ sum}
  end
  
  protected
  
  def _comparable
    instance_variables.map{|var|instance_variable_get var}
  end
end
