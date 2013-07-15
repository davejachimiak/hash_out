# hash_out

[![Build Status](https://travis-ci.org/davejachimiak/hash_out.png?branch=master)](https://travis-ci.org/davejachimiak/hash_out)

Adds a method that converts an instance's public methods to a hash of their names an values.

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
1. `require 'hash_out'`.
2. Include `HashOut` in your class.
3. If desired, exclude methods from `#hash_out` by adding `exclude_from_hash_out` to them.
4. Call `#hash_out` on the instance to return a hash of method names and their values.

**`#hash_out` automatically excludes methods that require arguments and private methods.**

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

  def available_instantly? catalog=TerribleStreamingService
    catalog.available_instantly? self
  end

  def has_actor? actor
    actors.include? actor
  end

  def terrible_example_method_that_wont_be_hashed_out yo, sup=nil
    :ugh
  end

  private

  def actors
    ['Sheryl Lee', 'David Bowie', 'Ray Wise']
  end
end

movie = Movie.new
movie.hash_out
# => {:title=>"Fire Walk With Me", :available_instantly?=>true}

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
