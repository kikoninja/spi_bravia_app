class PackagesVideo < ActiveRecord::Base
  use_connection_ninja(:controlcenter)

  belongs_to :video
  belongs_to :package

end
