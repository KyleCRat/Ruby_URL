Gem::Specification.new do |s|
  s.name        = 'URL'
  s.version     = URL::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['MIT']
  s.email       = 'kylecrat@gmail.com'
  s.summary     = 'Intuitive and powerful tools to work with urls'
  s.description = 'Intuitive and powerful tools to work with urls'
  s.homepage    = 'https://github.com/KyleCRat/Ruby_URL'

  s.files         = Dir['/**/*', 'CHANGELOG.md', 'LICENSE.md', 'README.md']
  s.require_paths = ['lib']
end
