class AddFieldsToAsset < ActiveRecord::Migration
  def change
    add_column :assets, :thumbnail_url, :string
    add_column :assets, :live, :boolean, :default => false
    add_column :assets, :source_url, :string      
    add_column :assets, :rating, :string
  end
end
