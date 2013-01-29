class AddRegionRefToPublishers < ActiveRecord::Migration
  def change
    add_column :publishers, :region_ref, :integer
  end
end
