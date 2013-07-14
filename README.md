# hash_out
Adds a method that returns a hash of public method names and values to your class' instances.

## Install
Add to your Gemfile:
`gem 'hash_out', '~> 0.1'

Or install it from the command line:
`$ gem install hash_out`

## Usage
1. Require it in your Gemfile.
2. Include `HashOut` in your class.
3. If you wish, exclude methods from being included with `exclude_from_hash_out`.
4. Call `#hash_out` on the instance to return a hash of public method names and their values.

`#hash_out` does not return private methods.

## License
