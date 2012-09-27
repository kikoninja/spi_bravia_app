class CreateAffiliatedUsers < ActiveRecord::Migration
  def change
    create_table :affiliated_users do |t|
      t.string :username
      t.string :suit

      t.timestamps
    end
  end
end
