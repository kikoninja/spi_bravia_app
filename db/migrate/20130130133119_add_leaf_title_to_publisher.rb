class AddLeafTitleToPublisher < ActiveRecord::Migration
  def change
    add_column :publishers, :leaf_title, :string
  end
end
