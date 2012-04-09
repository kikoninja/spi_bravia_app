class CreateAssetCategorizations < ActiveRecord::Migration
  def change
    create_table :asset_categorizations do |t|
      t.integer :asset_id
      t.integer :category_id

      t.timestamps
    end
  end
end
