class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      t.boolean :request
      t.integer :myself_id
      t.integer :partner_id
      t.timestamps
    end
    add_index :friends, :myself_id
    add_index :friends, :partner_id
    add_index :friends, [:myself_id, :partner_id], unique: true
  end
end
