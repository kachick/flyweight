$VERBOSE = true
require_relative 'test_helper'

class TestBasicCase < Test::Unit::TestCase
  class Material
    include Flyweight
    
    def initialize(looks, price)
      @looks, @price = looks, price
    end
  end

  class SubMaterial < Material
  end

  def test_normaly
    a = Material.value :metal, 2000
    b = Material.value :metal, 2000
    c = Material.new   :metal, 2000
    d = Material.value :paper, 50
    e = SubMaterial.value :metal, 2000
    assert_equal b, a
    assert_same b, a
    assert_equal c, a
    assert_same false, c.equal?(a)
    assert_same false, c.__id__.equal?(a.__id__)
    assert_same false, (d == a)
    assert_same false, d.equal?(a) 
    assert_same false, d.__id__.equal?(a.__id__)
    assert_equal e, a
    assert_same false, e.equal?(a)
    assert_same false, e.__id__.equal?(a.__id__)
  end
end
