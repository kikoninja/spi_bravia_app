class Channel < ActiveRecord::Base

  # Associations
  has_many :categories
  has_many :feeds

  # Accessibles
  attr_accessible :title, :description
end
