class Role < ActiveRecord::Base
  use_connection_ninja(:controlcenter)

  has_many :inv_user_roles, :through => :inv_users

end