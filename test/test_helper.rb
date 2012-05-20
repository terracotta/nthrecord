$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'test/unit'
require 'factory_girl'
require 'faker'
require 'shoulda'
require 'active_record'
require 'active_support/dependencies'
require 'active_support/core_ext/logger'
require 'nthrecord'

MODELS_PATH = File.join(File.dirname(__FILE__), 'models')


ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.logger.level = Logger::WARN

config = YAML::load(File.open(File.expand_path("../databases.yml", __FILE__)))
version = ActiveRecord::VERSION::STRING
driver = (ENV["DB"] or "sqlite3").downcase
in_memory = config[driver]["database"] == ":memory:"
    
commands = {
  "mysql"    => "mysql -e 'create database randumb_test;'",
  "postgres" => "psql -c 'create database randumb_test;' -U postgres"
}
%x{#{commands[driver] || true}}
    
ActiveRecord::Base.establish_connection config[driver]
puts "Using #{RUBY_VERSION} AR #{version} with #{driver}"


ActiveRecord::Base.connection.create_table(:players, :force => true) do |t|
  t.string   "name"
  t.datetime "created_at"
  t.datetime "updated_at"'<top (required)>'
 
end
  

dep = defined?(ActiveSupport::Dependencies) ? ActiveSupport::Dependencies : ::Dependencies
dep.autoload_paths.unshift MODELS_PATH


require File.dirname(__FILE__) + '/models/factories'
