class InvUser < ActiveRecord::Base
  use_connection_ninja(:controlcenter)
  set_table_name :users
end