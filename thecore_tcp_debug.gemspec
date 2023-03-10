$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "thecore_tcp_debug/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "thecore_tcp_debug"
  spec.version     = ThecoreTcpDebug::VERSION
  spec.authors     = ["Gabriele Tassoni"]
  spec.email       = ["gabrieletassoni@alchemic.it"]
  spec.homepage    = "https://devops.bancolini.com/dev/spot/backend/wrappers/thecore-spot-overrides"
  spec.summary     = "Gemt o collect UI overrides."
  spec.description = "In this gem all the CSS overrides wil be tracked."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'net-ping', '~> 2.0'
  spec.add_dependency 'thecore_ui_rails_admin', '~> 3.0'
end
