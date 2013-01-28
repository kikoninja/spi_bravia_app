class Publisher < ActiveRecord::Base
  has_many :packages
  has_many :packages_videos, :through => :packages 
  belongs_to :region

  attr_accessible :publisher_id, :country_code
end