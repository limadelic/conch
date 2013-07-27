Gem::Specification.new do |s|
  s.name          = 'conch'
  s.version       = '0.0.6'
  s.summary       = 'shell in the browser'
  s.authors       = ['limadelic']
  s.email         = 'limadelic@gmail.com'
  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.homepage      = 'http://www.c0nch.com'
  s.license       = 'MIT'

  s.add_dependency 'em-websocket', '>= 0.5.0'
  s.add_development_dependency 'bundler', "~> 1.3"
  s.add_development_dependency 'rake'
end