class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.integer :publisher_id
      t.string :country_code

      t.timestamps
    end
  end
end
