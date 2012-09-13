class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string :username
      t.string :email
      t.boolean :admin, :default => false

      t.timestamps
    end

    add_index :users, :email,                :unique => true
  end

  def self.down
    drop_table :users
  end
end
