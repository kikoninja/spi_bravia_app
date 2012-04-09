class Asset < ActiveRecord::Base
  attr_accessible :asset_type, :content_id, :description, :duration, :pay_content, :title
end
