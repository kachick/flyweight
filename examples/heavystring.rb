#!/usr/local/bin/ruby -w

$VERBOSE = true

require_relative '../lib/flyweight'

class MyString
  class Char
    include Flyweight
    
    def initialize(content)
      @content = content
    end
    
    def to_str
      @content
    end
    
    alias_method :to_s, :to_str
  end
  
  attr_reader :chars

  def initialize(str)
    @chars = str.chars.map{|c|Char.intern c}
  end
  
  def to_str
    @chars.join
  end
  
  alias_method :to_s, :to_str
end

foo = 'fooooobar!'
bar = MyString.new foo
puts foo                                          #=> fooooobar!
puts bar                                          #=> fooooobar!
p foo.chars.to_a[0].equal?(foo.chars.to_a[1])     #=> false
p foo.chars.to_a[1].equal?(foo.chars.to_a[2])     #=> false
p bar.chars[0].equal?(bar.chars[1])               #=> false
p bar.chars[1].equal?(bar.chars[2])               #=> true