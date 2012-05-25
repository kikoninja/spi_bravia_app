class CreateAssetCategorizations < ActiveRecord::Migration
  def change
    create_table :asset_categorizations, :id => false do |t|
      t.integer :asset_id
      t.integer :category_id
    end
  end
end
