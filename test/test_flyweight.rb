$VERBOSE = true
require_relative 'test_helper'

class TestBasicCase < Test::Unit::TestCase
  class Material
    include Flyweight
    
    def initialize(looks, price)
      @looks, @price = looks, price
    end
    
    def values
      [@looks, @price]
    end
  end

  class SubMaterial < Material
  end

  def test_normaly
    a = Material.intern :metal, 2000
    b = Material.intern :metal, 2000
    c = Material.new    :metal, 2000
    d = Material.intern :paper, 50
    e = SubMaterial.intern :metal, 2000
    
    assert_equal b, a
    assert_same b, a
    assert_equal c, a
    assert_same false, c.equal?(a)
    assert_same false, c.__id__.equal?(a.__id__)
    assert_same false, (d == a)
    assert_same false, d.equal?(a) 
    assert_same false, d.__id__.equal?(a.__id__)
    assert_equal e.values, a.values
    assert_same false, (e == a)
    assert_same false, e.equal?(a)
    assert_same false, e.__id__.equal?(a.__id__)
    
    hash = {a => true}
    assert_same true, hash[b]
    assert_same true, hash[c]
    assert_nil hash[d]
    assert_nil hash[e]
  end
  
  def test_class_clone
    klass1, klass2 = Material.clone, Material.clone
    assert_same false, klass1.equal?(klass2)
    assert_same false, klass1.new(:metal, 2000).equal?(klass2.new(:metal, 2000))
    assert_same false, klass1.intern(:metal, 2000).equal?(klass2.intern(:metal, 2000))
  end
end
