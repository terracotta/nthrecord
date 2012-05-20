Gem::Specification.new do |s|
  s.name                   = 'nthrecord'
  s.version                = '0.1.2'
  s.date                   = '2012-05-19'
  s.summary                = 'returns every nth record in a query'
  s.description            = 'Nthrecord is a simple tool for querying a database and returning every nth record.'
  s.authors                = 'Sean Harvey'
  s.email                  = 'seanharvey@gmail.com'
  s.files                  = ['lib/nthrecord.rb']
  s.homepage               = 'http://rubygems.org/gems/nthrecord'
  s.add_runtime_dependency('activerecord', '>= 3.2.3')
end


