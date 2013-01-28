class AddRegionIdToPublishers < ActiveRecord::Migration
  def change
    add_column :publishers, :region_id, :integer
  end
end
