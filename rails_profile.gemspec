$:.push File.expand_path('lib', __dir__)
require 'rails_profile/version'

Gem::Specification.new do |s|
  s.name = 'rails_profile'
  s.version = RailsProfile::VERSION
  s.authors = ['qinmingyuan']
  s.email = ['mingyuan0715@foxmail.com']
  s.homepage = 'https://github.com/work-design/rails_profile'
  s.summary = 'User Profile'
  s.description = ' Description of '
  s.license = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'rails_com', '~> 1.2'
  s.add_development_dependency 'sqlite3'
end
