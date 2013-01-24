class Publisher < ActiveRecord::Base
  has_many :packages

  attr_accessible :publisher_id, :country_code
end