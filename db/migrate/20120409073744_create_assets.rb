class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :title
      t.text :description
      t.string :content_id
      t.boolean :pay_content
      t.string :asset_type
      t.integer :duration

      t.timestamps
    end
  end
end
