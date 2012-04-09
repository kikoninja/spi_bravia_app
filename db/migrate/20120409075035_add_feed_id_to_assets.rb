class AddFeedIdToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :feed_id, :integer
  end
end
