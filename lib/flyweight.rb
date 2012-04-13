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
#   a = Material.value :metal, 2000
#   b = Material.value :metal, 2000
#   c = Material.new   :metal, 2000
#   d = Material.value :paper, 50
#   a == b     #=> true
#   a.equal? b #=> true
#   a == c     #=> true
#   a.equal? c #=> false
#   a == d     #=> false
#   a.equal? d #=> false
module Flyweight
  VERSION = '0.0.1'.freeze

  module Eigen
    def value(*values)
      pool = if singleton_class.const_defined? :FLYWEIGHT_POOL, false
               singleton_class::FLYWEIGHT_POOL
             else
               singleton_class.const_set :FLYWEIGHT_POOL, {}
             end

      if pool.has_key? values
        pool[values]
      else
        pool[values] = new(*values)
      end
    end
  end

  class << self
    def included(mod)
      raise ArgumentError unless mod.kind_of? ::Module
      
      mod.extend Eigen
     # mod.singleton_class.const_set :FLYWEIGHT_POOL, {}
    end
  end

  def ==(other)
    sources_for = ->obj{
      obj.instance_variables.map{|var|obj.instance_variable_get var}
    }

    sources_for[self] == sources_for[other]
  end
end
