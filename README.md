# hash_out

[![Build Status](https://travis-ci.org/davejachimiak/hash_out.png?branch=master)](https://travis-ci.org/davejachimiak/hash_out)

Include `HashOut` in your class and convert your object to a hash with the `#hash_out` method.

## Install
Add to your Gemfile:
```ruby
gem 'hash_out', '~> 0.2'
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

To exclude public methods from `#hash_out`, call the `#exclude_from_hash_out` method in them.
`#exclude_from_hash_out` blocks any attribute mutation that occurs during a normal call to the
method.

```ruby
require 'hash_out'

class Post
  include HashOut

  attr_reader :upvotes

  def initialize
    @upvotes = 1000000
  end

  def title
    'Twin Peaks fuckin rocks'
  end

  def upvote
    exclude_from_hash_out
    @upvotes += 500000
  end
end

post = Post.new
post.hash_out
# => {:title=>"Twin Peaks fuckin rocks", :upvotes=>1000000}

post.upvote
post.hash_out
# => {:title=>"Twin Peaks fuckin rocks", :upvotes=>1500000}
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

Delegators introduced by Forwardable can be excluded by declaring
`exclude_delegators_from_hash_out`. (`Forwardable` must be
extended *before* `HashOut` is included.)
```ruby
require 'hash_out'
require 'forwardable'

class Movie
  extend  Forwardable
  include HashOut

  exclude_delegators_from_hash_out

  def_delegator :@title, :upcase

  def initialize
    @title = 'Fire Walk With Me'
  end

  def screaming_title
    upcase
  end
end

Movie.new.hash_out
# => {:screaming_title=>"FIRE WALK WITH ME"}
```

## Contribute
1. Fork the repo.
2. Create a branch.
3. Add specs and code.
4. Ensure the specs are green (`$ rake`)
5. Open a pull request.

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
