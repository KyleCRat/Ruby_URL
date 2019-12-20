# -*- encoding: utf-8 -*-
# frozen_string_literal: true

$:.push File.expand_path('../lib', __FILE__)
require 'url/version'

Gem::Specification.new do |s|
  s.name        = 'URL'
  s.version     = URL::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ['MIT']
  s.email       = 'kylecrat@gmail.com'
  s.summary     = 'Intuitive and powerful tools to work with urls'
  s.description = 'Intuitive and powerful tools to work with urls'
  s.homepage    = 'https://github.com/KyleCRat/Ruby_URL'
  s.authors     = ['Kyle Ratliff']

  s.files         = Dir['lib/**/*', 'CHANGELOG.md', 'LICENSE.md', 'README.md']
  s.require_paths = ['lib']

  s.add_development_dependency "rspec"
end
