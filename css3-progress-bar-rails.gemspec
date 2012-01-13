# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "css3-progress-bar-rails/version"

Gem::Specification.new do |s|
  s.name        = "css3-progress-bar-rails"
  s.version     = Css3::Progress::Bar::Rails::VERSION
  s.authors     = ["Nicholas Fine", "Josh Sullivan"]
  s.email       = ["nicholas.fine@gmail.com", "josh@dipperstove.com"]
  s.homepage    = "http://ndfine.com/2012/01/03/css3-progress-bars-for-rails.html"
  s.summary     = %q{Integrates Josh Sullivan's CSS3 Progress Bars into Rails 3.1+ Projects.}
  s.description = %q{Integrates Josh Sullivan's CSS3 Progress Bars into Rails and adds ActionView helpers for generation.}

  s.rubyforge_project = "css3-progress-bar-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rails", ">= 3.1"
  s.add_development_dependency "minitest"
  s.add_development_dependency "nokogiri"
end
