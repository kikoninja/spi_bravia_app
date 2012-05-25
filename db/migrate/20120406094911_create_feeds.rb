class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :channel_id
      t.string :title

      t.timestamps
    end
  end
end
