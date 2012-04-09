class Video < ActiveRecord::Base
  use_connection_ninja(:controlcenter)

  # Associations
  has_one :asset
  has_many :video_custom_attributes

  # Scopes
  default_scope where('user_id =?', 5842)

end
