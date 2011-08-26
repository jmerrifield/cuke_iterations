# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cuke_iterations/version"

Gem::Specification.new do |s|
  s.name        = "cuke_iterations"
  s.version     = CukeIterations::VERSION
  s.authors     = ["Jon Merrifield"]
  s.email       = ["jon@jmerrifield.com"]
  s.homepage    = "https://github.com/jmerrifield/cuke_iterations"
  s.summary     = %q{Multiple iterations for Cucumber features}
  s.description = %q{Run your Cucumber features multiple times within one Cucumber invocation}

  s.rubyforge_project = "cuke_iterations"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency 'gherkin'
end
