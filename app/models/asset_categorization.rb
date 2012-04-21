class AssetCategorization < ActiveRecord::Base

  # Associations
  belongs_to :asset
  belongs_to :category

  attr_accessible :asset_id, :category_id, :created_at, :updated_at


end
