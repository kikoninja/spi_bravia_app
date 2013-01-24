class InvUserRole < ActiveRecord::Base
  use_connection_ninja(:controlcenter)

  belongs_to :inv_users
  belongs_to :roles
  
end