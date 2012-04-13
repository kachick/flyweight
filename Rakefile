gem 'hoe', '~> 3.0.3'
require 'hoe'
require 'fileutils'

Hoe.plugin :newgem

$hoe = Hoe.spec 'flyweight' do
  developer 'Kenichi Kamiya', 'kachick1+ruby@gmail.com'
  self.rubyforge_name       = name
  require_ruby_version '>= 1.9.2'
  dependency 'yard', '~> 0.7.5', :development
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }
