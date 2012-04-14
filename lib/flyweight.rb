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
  VERSION = '0.0.3.a'.freeze
  POOL_NAME = :FLYWEIGHT_POOL
  
  module Eigen
    def intern(*values)
      pool = if singleton_class.const_defined? POOL_NAME, false
               singleton_class.const_get POOL_NAME
             else
               singleton_class.const_set POOL_NAME, {}
             end

      if pool.has_key? values
        pool[values]
      else
        pool[values] = new(*values)
      end
    end

    alias_method :value_for, :intern
    
    private
    
    def inherited(klass)
      klass.singleton_class.const_set POOL_NAME, {}
    end
  end

  class << self
    private
    
    def included(mod)
      mod.module_eval do
        extend Eigen
        singleton_class.const_set POOL_NAME, {}
      end
    end
  end

  def eql?(other)
    self.class == other.class && (
      sources_for = ->obj{
        obj.instance_variables.map{|var|obj.instance_variable_get var}
      }

      sources_for[self].__send__ __callee__, sources_for[other]
    )
  end
  
  alias_method :==, :eql?
  
  def hash
    instance_variables.inject(instance_variables.hash){|sum, var|
      instance_variable_get(var).hash ^ sum
    }
  end
end
