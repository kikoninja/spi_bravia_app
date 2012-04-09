class AddVideoIdToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :video_id, :integer
  end
end
