$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cms_gallery/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cms_gallery"
  s.version     = CmsGallery::VERSION
  s.authors     = ["Pavel Golenkov"]
  s.email       = ["p.golenkov@gmail.com"]
  s.homepage    = "https://github.com/pashex/cms_gallery"
  s.summary     = "Summary of CmsGallery."
  s.description = "Description of CmsGallery."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.6"
  s.add_dependency 'pg'
  s.add_dependency 'carrierwave'
  s.add_dependency 'mini_magick'
  s.add_dependency 'haml-rails'
  s.add_dependency 'simple_form'
  s.add_dependency 'bootstrap-sass'

  s.add_development_dependency "rspec-rails", "~> 3.1.0"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency 'shoulda-matchers'
end

