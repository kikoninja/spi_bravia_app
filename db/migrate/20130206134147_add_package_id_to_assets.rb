class AddPackageIdToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :package_id, :integer
  end
end
