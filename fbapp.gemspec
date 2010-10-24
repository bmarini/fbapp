# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fbapp/version"

Gem::Specification.new do |s|
  s.name        = "fbapp"
  s.version     = Fbapp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ben Marini"]
  s.email       = ["bmarini@gmail.com"]
  s.homepage    = "http://github.com/bmarini/fbapp"
  s.summary     = %q{Command line interface to your facebook apps}
  s.description = %q{Command line interface to your facebook apps}

  s.add_dependency "thor", "0.14.3"
  # s.add_dependency "celerity", "0.8.2"
  # s.add_dependency "jruby-openssl"
  s.add_dependency "mechanize", "1.0.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
