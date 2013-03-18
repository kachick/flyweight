#!/usr/local/bin/ruby -w

$VERBOSE = true

require_relative '../lib/flyweight'

class Material
  include Flyweight

  def initialize(looks, price)
    @looks, @price = looks, price
  end
end

a = Material.intern :metal, 2000
b = Material.intern :metal, 2000
c = Material.new    :metal, 2000
d = Material.intern :paper, 50
p a == b     #=> true
p a.equal? b #=> true
p a == c     #=> true
p a.equal? c #=> false
p a == d     #=> false
p a.equal? d #=> false