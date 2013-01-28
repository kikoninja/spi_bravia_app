class CreateRegion < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      
      t.timestamps
    end
  end
end
