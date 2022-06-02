class CreateCommunities < ActiveRecord::Migration[6.0]
  def change
    create_table :communities do |t|
      t.string :name
      t.string :icon
      t.integer :create_user_id
      t.string :comment
      t.timestamps
    end
  end
end
