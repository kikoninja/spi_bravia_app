class AssetCategorization < ActiveRecord::Base

  # Associations
  belongs_to :asset
  belongs_to :category

  attr_accessible :asset_id, :category_id

  validates_uniqueness_of :asset_id, :scope => [:category_id]


end
