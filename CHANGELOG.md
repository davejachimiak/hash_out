### version 0.1.4 - *July 18, 2013*
* Fixes bug (issue #1): `#exclude_from_hash_out` does not block mutation that may happen in the call.

  closes #1

### version 0.1.3 - *July 17, 2013*
* Fixes bug: multiple calls to `#hash_out` that are from an internal method infinitely recurse
* Fixes bug: method not present in hash when outside caller of `#hash_out` has same name
* Makes behavior more object-oriented
* Divides features into separate files
* Improves README in terms of understanding different features

### version 0.1.2 - *July 15, 2013*
* Fixes bug: internal calls to `#hash_out` infinitely recurse

### version 0.1.1 - *July 15, 2013*
* Changes rake to a development dependency from a runtime dependency

# version 0.1.0 - *July 15, 2013*
* Initial release
