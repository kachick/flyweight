#!/usr/local/bin/ruby -w

$VERBOSE = true

require 'benchmark'
require_relative '../lib/flyweight'

class Material
  include Flyweight

  def initialize(looks, price, other=nil)
    @looks, @price, @other = looks, price, other
  end
end

class HeavyParts
  DATA = 'str' * 100000000
  
  def initialize
    @content = DATA.dup
  end
end

TIMES = 100000

Benchmark.bm do |bm| 
  bm.report 'Light Instant .new' do
    klass = Class.new Material
    TIMES.times do
      klass.new :metal, 2000
    end
  end
  
  bm.report 'Light Instant .intern' do
    klass = Class.new Material
    TIMES.times do
      klass.intern :metal, 2000
    end
  end
  
  bm.report 'Light Keep .new' do
    klass = Class.new Material
    TIMES.times.map do
      klass.new :metal, 2000
    end
  end
  
  bm.report 'Light Keep .intern' do
    klass = Class.new Material
    TIMES.times.map do
      klass.intern :metal, 2000
    end
  end

  bm.report 'Heavy Instant .new' do
    klass = Class.new Material
    TIMES.times do
      klass.new :metal, 2000, HeavyParts.new
    end
  end
  
  bm.report 'Heavy Instant .intern' do
    klass = Class.new Material
    TIMES.times do
      klass.intern :metal, 2000, HeavyParts.new
    end
  end
  
  bm.report 'Heavy Keep .new' do
    klass = Class.new Material
    TIMES.times.map do
      klass.new :metal, 2000, HeavyParts.new
    end
  end
  
  bm.report 'Heavy Keep .intern' do
    klass = Class.new Material
    TIMES.times.map do
      klass.intern :metal, 2000, HeavyParts.new
    end
  end
end

