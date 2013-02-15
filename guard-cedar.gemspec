require File.expand_path("../lib/guard/cedar/version", __FILE__)

Gem::Specification.new do |s|
  s.name     = "guard-cedar"
  s.version  = Guard::CedarVersion::VERSION
  s.platform = Gem::Platform::RUBY
  s.homepage = "https://github.com/ohrite/guard-cedar"
  s.authors  = ["Doc Ritezel"]
  s.email    = "ritezel+guard-cedar@gmail.com"
  s.summary  = "Guard gem for Cedar."
  s.description = "Guard::Cedar automatically runs your Cedar suite."

  s.add_development_dependency "rspec"
  s.add_development_dependency "guard"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-bundler"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename( f ) }
  s.require_path  = "lib"
end
