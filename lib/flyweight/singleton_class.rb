module Flyweight

  class << self

    private
    
    def included(mod)
      mod.extend ClassMethods
    end
  
  end

end