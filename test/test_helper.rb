$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'active_record'
require 'test/unit'
require 'stripefy'

ActiveRecord::Base.establish_connection :adapter => "sqlite3", :database => "stripefy.db"
ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS 'stripefy_test_models'")
ActiveRecord::Base.connection.create_table(:stripefy_test_models) do |t|
  t.string :stripe_id
end

class StripefyTestModel < ActiveRecord::Base
end
