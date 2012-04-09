class Feed < ActiveRecord::Base

  # Associations
  has_many :assets

  attr_accessible :title, :assets
end
