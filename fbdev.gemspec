# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fbdev/version"

Gem::Specification.new do |s|
  s.name        = "fbdev"
  s.version     = Fbdev::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = "http://rubygems.org/gems/fbdev"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.add_dependency "thor", "0.14.3"
  # s.add_dependency "celerity", "0.8.2"
  # s.add_dependency "jruby-openssl"
  s.add_dependency "mechanize"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
