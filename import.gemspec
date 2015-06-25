$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "import/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "import"
  s.version     = Import::VERSION
  s.authors     = ["Sebastian Gaul"]
  s.email       = ["sgaul@milabent.com"]
  s.homepage    = "http://milabent.com"
  s.summary     = "A simple HTTP JSON import helper"
  s.description = "A simple HTTP JSON import helper"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.1"
  s.add_dependency "activeresource", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
end
