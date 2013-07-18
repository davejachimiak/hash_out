# hash_out

[![Build Status](https://travis-ci.org/davejachimiak/hash_out.png?branch=master)](https://travis-ci.org/davejachimiak/hash_out)

Include `HashOut` to your class and convert your object to a hash with the `#hash_out` method.

## Install
Add to your Gemfile:
```ruby
gem 'hash_out', '~> 0.1'
```

Or install it from the command line:
```sh
$ gem install hash_out
```

## Usage
`require 'hash_out'`, `include HashOut`, and call `#hash_out` on the instance.

```ruby
require 'hash_out'

class Movie
  include HashOut

  def title
    'Fire Walk With Me'
  end

  def director
    'David Lynch'
  end
end

Movie.new.hash_out
# => {:title=>"Fire Walk With Me", :director=>'David Lynch'}
```

To exclude public methods from `#hash_out`, put `exclude_from_hash_out` at the top of it.

```ruby
require 'hash_out'

class Movie
  include HashOut

  def title
    'Fire Walk With Me'
  end

  def director
    exclude_from_hash_out
    'David Lynch'
  end
end

Movie.new.hash_out
# => {:title=>"Fire Walk With Me"}
```

Private methods are ignored.
```ruby
require 'hash_out'

class Movie
  include HashOut

  def title
    'Fire Walk With Me'
  end

  private

  def director
    'David Lynch'
  end
end

Movie.new.hash_out
# => {:title=>"Fire Walk With Me"}
```

Public methods that require arguments are also ignored.
```ruby
require 'hash_out'

class Movie
  include HashOut

  def title
    'Fire Walk With Me'
  end

  def chance_of_sequel? existing_sequels, strategy=FutureSequelStrategy
    strategy.new(self, existing_sequels).chance > 0.5
  end
end

Movie.new.hash_out
# => {:title=>"Fire Walk With Me"}
```

Public methods that call `#hash_out` are ignored, too.

```ruby
require 'hash_out'

class Movie
  include HashOut

  def title
    'Fire Walk With Me'
  end

  def director
    'David Lynch'
  end

  def attributes
    hash_out
  end
end

movie = Movie.new
movie.attributes
# => {:title=>"Fire Walk With Me", :director=>'David Lynch'}
movie.hash_out
# => {:title=>"Fire Walk With Me", :director=>'David Lynch'}
```

## Contribute
1. Fork the repo.
2. Create a branch.
3. Add specs and code.
4. Ensure the specs are green (`$ rake`)
5. Open a pull request.

## TODO
* Bug: make `#hash_out` work with SimpleDelegator
* Provide class method that offers custom delegator for `#hash_out`
* Provide class method that offers alternative to `exclude_from_hash_out`
* Provide class method that allows for inclusion of protected and private methods in resulting hash.

## License
The MIT License (MIT)

Copyright (c) 2013 Dave Jachimiak

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
