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
  DATA = 'str' * 10000000
  
  def initialize
    @content = DATA.dup
  end
end

TIMES = 100000

Benchmark.bm do |bm| 
  bm.report 'Light Instant .new' do
    TIMES.times do
      Material.new :metal, 2000
    end
  end
  
  bm.report 'Light Instant .intern' do
    TIMES.times do
      Material.intern :metal, 2000
    end
  end
  
  bm.report 'Light Keep .new' do
    TIMES.times.map do
      Material.new :metal, 2000
    end
  end
  
  bm.report 'Light Keep .intern' do
    TIMES.times.map do
      Material.intern :metal, 2000
    end
  end

  bm.report 'Heavy Instant .new' do
    TIMES.times do
      Material.new :metal, 2000, HeavyParts.new
    end
  end
  
  bm.report 'Heavy Instant .intern' do
    TIMES.times do
      Material.intern :metal, 2000, HeavyParts.new
    end
  end
  
  bm.report 'Heavy Keep .new' do
    TIMES.times.map do
      Material.new :metal, 2000, HeavyParts.new
    end
  end
  
  bm.report 'Heavy Keep .intern' do
    TIMES.times.map do
      Material.intern :metal, 2000, HeavyParts.new
    end
  end
end

