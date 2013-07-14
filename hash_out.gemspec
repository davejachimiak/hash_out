# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require 'hash_out/version'

Gem::Specification.new do |s|
  s.name          = 'hash_out'
  s.description   = 'Easily convert public methods to a hash.'
  s.summary       = "hash_out adds a method to your class' instance and returns hash of public method names and values."
  s.authors       = ['Dave Jachimiak']
  s.email         = 'dave.jachimiak@gmail.com'
  s.homepage      = 'http://github.com/davejachimiak/hash_out'
  s.version       = HashOut::VERSION
  s.license       = 'MIT'
  s.files         = `git ls-files`.split("\n").reject do |file_name|
    /\.gem$/.match file_name
  end
  s.test_files    = `git ls-files -- spec`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'rake'
  s.add_development_dependency 'minitest-spec-expect', '~> 0.1'
end
