class AddRegionRefToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :region_ref, :integer
  end
end
