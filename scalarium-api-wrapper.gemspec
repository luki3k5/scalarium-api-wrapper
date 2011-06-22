# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scalarium-api-wrapper/version"

Gem::Specification.new do |s|
  s.name        = "scalarium-api-wrapper"
  s.version     = Scalarium::Api::Wrapper::VERSION
  s.authors     = ["luki3k5"]
  s.email       = ["luki3k5@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{This is scalarium API wrapper}
  s.description = %q{This is scalarium API wrapper, allowing to execute API calls to scalarium backend}

  s.add_dependency('json')
  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', '~> 2.0')

  s.rubyforge_project = "scalarium-api-wrapper"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
