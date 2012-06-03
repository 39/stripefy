# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stripefy/version"

Gem::Specification.new do |s|
  s.name        = "stripefy"
  s.version     = Stripefy::VERSION
  s.authors     = ["39", "Alejandro Cadavid"]
  s.email       = ["info@39inc.com", "acadavid@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Get your model ready to interact with Stripe.com}
  s.description = %q{This gem wraps the stripe-ruby gem, allowing an ActiveRecord model to be easily suscriptable with Stripe}

  s.rubyforge_project = "stripefy"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails"
  s.add_dependency "stripe"

  s.add_development_dependency "test-unit"
  s.add_development_dependency "mocha"
  s.add_development_dependency "sqlite3"
end
