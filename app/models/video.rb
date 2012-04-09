class Video < ActiveRecord::Base
  use_connection_ninja(:controlcenter)

  # Associations
  has_one :asset

  # Scopes
  default_scope where('user_id =?', 5842)

end
