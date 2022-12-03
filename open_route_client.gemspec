
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "open_route_client/version"

Gem::Specification.new do |spec|
  spec.name          = "open_route_client"
  spec.version       = OpenRouteClient::VERSION
  spec.authors       = ["Jakub Godawa"]
  spec.email         = ["jakub.godawa@gmail.com"]

  spec.summary       = %q{OpenRouteService wrapper for Ruby.}
  spec.description   = %q{Use the OpenRouteService API in your favorite language.}
  spec.homepage      = "https://github.com/vysogot/open_route_client"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.12"

  spec.add_dependency "rest-client", "~> 2.1"
  spec.add_dependency "json", "~> 2.6"
end
