flyweight
=============

* ***This repository is archived***
* ***No longer maintained***
* ***All versions have been yanked from https://rubygems.org/ for releasing valuable namespace for others***

Description
-----------

A tiny template for the "Flyweight Pattern".

Features
--------

* MyClass.intern

Usage
-----

```ruby
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
a == b     #=> true
a.equal? b #=> true
a == c     #=> true
a.equal? c #=> false
a == d     #=> false
a.equal? d #=> false
```

Requirements
-------------

* Ruby 1.9.2 or later

License
--------

The MIT X11 License  
Copyright (c) 2012 Kenichi Kamiya  
See MIT-LICENSE for further details.