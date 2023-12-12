Gem::Specification.new do |s|
  s.name = 'rails_profile'
  s.version = '0.0.1'
  s.authors = ['Mingyuan Qin']
  s.email = ['mingyuan0715@foxmail.com']
  s.summary = 'User Profile'
  s.description = ' Description of '

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]

  s.add_dependency 'rails_com', '~> 1.2'
end
