class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :description
      t.string :style
      t.integer :order
      t.string :icon
      t.integer :channel_id

      t.timestamps
    end
  end
end
