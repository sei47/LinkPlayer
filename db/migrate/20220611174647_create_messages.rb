class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :message
      t.string :message_image
      t.references :friend, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
