# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require 'public_hash/version'

Gem::Specification.new do |s|
  s.name          = 'public_hash'
  s.description   = 'Easily convert public methods to a hash.'
  s.summary       = 'public_hash adds a method that returns hash of public method names and values..'
  s.authors       = ['Dave Jachimiak']
  s.email         = 'dave.jachimiak@gmail.com'
  s.homepage      = 'http://github.com/davejachimiak/public_hash'
  s.version       = PublicHash::VERSION
  s.files         = `git ls-files`.split("\n").reject do |file_name|
    /\.gem$/.match file_name
  end
  s.test_files    = `git ls-files -- spec`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'minitest-spec-expect', '0.1.1'
end
