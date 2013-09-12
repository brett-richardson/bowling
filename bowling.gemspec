# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bowling/version'

Gem::Specification.new do |spec|
  spec.name          = "Bowling"
  spec.version       = Bowling::VERSION
  spec.authors       = [ "Brett Richardson" ]
  spec.email         = [ "Brett.Richardson.NZ@gmail.com" ]
  spec.description   = 'Calculates a bowling score'
  spec.summary       = File.expand_path File.join( File.dirname( __FILE__ ), 'README.md' )
  spec.homepage      = "http://www.dablweb.com"
  spec.license       = "MIT"

  spec.files         = [ `git ls-files`.split( $/ ) ]
  spec.executables   = [ 'bowling_game' ]
  spec.test_files    = spec.files.grep( %r{^(test|spec|features)/} )
  spec.require_paths = [ "lib" ]

  spec.add_runtime_dependency "highline"
  spec.add_runtime_dependency "formatador"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"
end
