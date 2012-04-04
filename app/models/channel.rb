class Channel < ActiveRecord::Base

  # Associations
  has_many :categories

  # Accessibles
  attr_accessible :title
end
