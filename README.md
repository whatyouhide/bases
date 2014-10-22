# Bases

[![Build Status](https://travis-ci.org/whatyouhide/bases.svg?branch=master)](https://travis-ci.org/whatyouhide/bases)
[![Gem Version](https://badge.fury.io/rb/bases.svg)](http://badge.fury.io/rb/bases)
[![Coverage Status](https://img.shields.io/coveralls/whatyouhide/bases.svg)](https://coveralls.io/r/whatyouhide/bases)
[![Code Climate](https://codeclimate.com/github/whatyouhide/bases/badges/gpa.svg)](https://codeclimate.com/github/whatyouhide/bases)
[![Dependency Status](https://gemnasium.com/whatyouhide/bases.svg)](https://gemnasium.com/whatyouhide/bases)
[![Inline docs](http://inch-ci.org/github/whatyouhide/bases.svg?branch=master&style=flat)](http://inch-ci.org/github/whatyouhide/bases)

Convert **from** and **to** any base you can think of.

A bunch of features:

* Convert to bases up to **whatever you want!**
* Use custom bases defined as arrays, like this binary base: `['↓', '↑']`.
* Use multicharacter digits.
* Use **emojis** as digits!
* Fall back to Ruby's `Integer#to_s` and `String#to_i` when the base is less
    than 36.
* Superdocumented, tested like shuttle launches were depending on it (this may
    not be true).
* Supports MRI Ruby (yeah, just Ruby) from version 1.9.3.


## Why

Ruby can convert bases, but only with bases up to 36. But converting to bigger
basis is just as fun (if not even more!), since you can easily reduce the number
of character used to represent a number.

I only know of gem that does this, [radix][radix]. Radix isn't bad, but I don't
like it because it monkeypatches everything. It provides the `b`
method on strings, which on recent versions of Ruby is also a [default
method][ruby-string-b].


## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'bases'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

``` bash
$ gem install bases
```


## Usage

The main hub for the usage of this gem is the `Bases.val` method.
It takes a parameter that can be a bunch of things.

* An integer: in this case, the source base is assumed to be the decimal base.
* An array: no base is assumed, you have to manually specify it (keep reading!).
    The array is assumed to be a list of digits (each element is a digit) from
    the most significant one to the least significant one, like you'd expect.
* A string: no base is assumed. If the string doesn't contain whitespace, each
    character is assumed to be a digit; otherwise, whitespace is assumed to
    separate multicharacter digits (wow, multicharacter digits!).

The return value of `Bases.val` is junk (sort of), so you want to
call some methods to specify a *source base* and a *destination base*.

Those methods are the `in_base` and `to_base` methods:

``` ruby
Bases.val('100').in_base(2).to_base(10)  #=> '4'
Bases.val('1111').in_base(2).to_base(16) #=> 'f'
Bases.val('A').in_base(16).to_base(10)   #=> '10'
```

The `to_base` method always returns a `String`, even with `to_base(10)`. To
overcome that, just call `to_i` on the string.

When you pass an integer to `val`, base 10 is assumed:

``` ruby
Bases.val(10).to_base(Bases::HEX) #=> 'A'
Bases.val(0b1011).to_base(2)                  #=> '1011'
```

#### Bracket syntax

`Bases.val` is aliased to `Bases.[]`, so that you can
easily create values with a clean syntax:

``` ruby
Bases[5].to_base(2) #=> '101'
```

#### Array bases

You can use arrays everywhere you can use a base. The elements of the array will
be the digits of the new base, from left to right. Defining a base through an
array is easy:

``` ruby
# An alternative way of defining base 2:
base2 = [0, 1]

# A very cool alternative binary base:
christmas_star_base = %w(+ ≈)

# A (contrived) example of base64:
base64 = ('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a + %w(+ /)
```

#### Predefined bases

Some default (common) bases are offered as constants:

``` ruby
Bases::B62    #=> base 62 (alphanumeric)
Bases::B64    #=> base64
```

#### Common bases

The gem provides a bunch of methods for dealing with common bases. These methods
should be used in place of the `in_base` and `to_base` methods.

They are:

- `in_binary`/`to_binary`
- `in_hex`/`to_hex` (`in_hex` solves the issue noted in the [hexadecimal base
    section](#hex))

Since the decimal is also common, a `to_i` method is included. This method
returns an integer, not a string, in order to conform with the Ruby standard
library.

``` ruby
Bases.val('1010').in_binary.to_i #=> 10
```

### Monkeypatching

I can see the appeal of monkeypatching (can I?). So, you can specifically
require to monkeypatch the `Integer`, `Array` and `String` Ruby classes:

``` ruby
# Instead of just 'bases':
require 'bases/monkeypatches'

2.to_base [:a, :b] #=> 'ba'
10.to_binary #=> '1010'
15.to_hex #=> 'f'

'A'.in_hex.to_i #=> 10
'baba'.in_base([:a, :b]).to_base(2) #=> '1010'

['foo', 'bar'].in_base(['foo', 'bar', 'baz']).to_i #=> 1
```


## Contributing

Fork, make changes, commit those changes, push to your fork, create a new Pull
Request here. Thanks!



[radix]: https://github.com/rubyworks/radix
[ruby-string-b]: http://www.ruby-doc.org/core-2.1.3/String.html#method-i-b
