# hash_out
Adds a method that returns a hash of public method names and values to your class' instances.

## Install
Add to your Gemfile:
```ruby
gem 'hash_out', '~> 0.1'
```

Or install it from the command line:
`$ gem install hash_out`

## Usage
1. Require it in your Gemfile.
2. Include `HashOut` in your class.
3. If you wish, exclude methods from being included with `exclude_from_hash_out`.
4. Call `#hash_out` on the instance to return a hash of public method names and their values.

`#hash_out` automatically excludes methods that require arguments and private methods.

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

  def release_year
    1992
  end

  def budget
    exclude_from_hash_out
    USD.new 10000000
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

movie.hash_out
# => {:title=>"Fire Walk With Me", :director=>"David Lynch", :release_year=>1992, :available_instantly?=>true}

```

## License
