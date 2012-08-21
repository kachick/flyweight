# flyweight
#   A tiny template for the "Flyweight Pattern"

# Copyright (C) 2012  Kenichi Kamiya

require_relative 'flyweight/version'
require_relative 'flyweight/classmethods'
require_relative 'flyweight/singletonclass'

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
  
  def eql?(other)
    (other.instance_of? self.class) &&
      _comparable.__send__(__callee__, other._comparable)
  end
  
  alias_method :==, :eql?
  
  # @return [Integer]
  def hash
    _comparable.inject(0){|sum, val|val.hash ^ sum}
  end
  
  protected
  
  def _comparable
    instance_variables.map{|var|instance_variable_get var}
  end

end
