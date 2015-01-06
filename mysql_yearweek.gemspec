Gem::Specification.new do |s|
  s.name        = 'mysql_yearweek'
  s.version     = '1.0.1'
  s.date        = '2013-07-26'
  s.summary     = 'Returns yearweek values equivalent to the MySQL function'
  s.description = <<-eos
    MySQL's `yearweek` function has eight different modes for determining the
    yearweek. This will get the same yearweek for each mode, with `4` being the
    default mode.
  eos
  s.authors     = ['Dean Morin']
  s.email       = 'morin.dean@gmail.com'
  s.homepage    = 'http://github.com/deanmorin/mysql_yearweek'
  s.license     = 'MIT'
  s.files       = ['lib/mysql_yearweek.rb']
end
