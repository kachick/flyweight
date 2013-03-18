flyweight
=============

[![Build Status](https://secure.travis-ci.org/kachick/flyweight.png)](http://travis-ci.org/kachick/flyweight)
[![Gem Version](https://badge.fury.io/rb/flyweight.png)](http://badge.fury.io/rb/flyweight)

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

* [Ruby 1.9.2 or later](http://travis-ci.org/#!/kachick/flyweight)

Install
-------

```bash
$ gem install flyweight
```

Link
----

* [Home](https://kachick.github.com/flyweight)
* [code](https://github.com/kachick/flyweight)
* [API](http://kachick.github.com/flyweight/yard/frames.html)
* [issues](https://github.com/kachick/flyweight/issues)
* [CI](http://travis-ci.org/#!/kachick/flyweight)
* [gem](https://rubygems.org/gems/flyweight)

License
--------

The MIT X11 License  
Copyright (c) 2012 Kenichi Kamiya  
See MIT-LICENSE for further details.