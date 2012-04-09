class VideoCustomAttribute < ActiveRecord::Base
  use_connection_ninja(:controlcenter)

  # Associations
  belongs_to :video

end
