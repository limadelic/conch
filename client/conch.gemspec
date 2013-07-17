Gem::Specification.new do |s|
  s.name          = 'conch'
  s.version       = '0.0.1'
  s.summary       = 'shell in the browser'
  s.description   = "A simple hello world gem"
  s.authors       = ['limadelic']
  s.email         = 'limadelic@gmail.com'
  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.homepage      = 'http://www.c0nch.com'
end