# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'workflow_to_hash/version'

Gem::Specification.new do |spec|
  spec.name          = "workflow_to_hash"
  spec.version       = WorkflowToHash::VERSION
  spec.authors       = ["Rob Nichols"]
  spec.email         = ["rob@nicholshayes.co.uk"]

  spec.summary       = %q{A tool to allow a sequence of actions in a state machine to be defined as an array}
  spec.description   = %q{Takes `[:one, :two, :three]` and convert it to `{one: :two, two: :three}`}
  spec.homepage      = "https://github.com/reggieb/workflow_to_hash"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.14"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.0"
end
