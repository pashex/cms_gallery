$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cms_gallery/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cms_gallery"
  s.version     = CmsGallery::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of CmsGallery."
  s.description = "TODO: Description of CmsGallery."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.6"
  s.add_dependency 'pg'
  s.add_dependency 'carrierwave'

  s.add_development_dependency "rspec-rails", "~> 3.1.0"
  s.add_development_dependency "factory_girl_rails"
end

