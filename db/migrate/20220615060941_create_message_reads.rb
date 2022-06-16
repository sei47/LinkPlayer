class CreateMessageReads < ActiveRecord::Migration[6.0]
  def change
    create_table :message_reads do |t|
      t.integer :message_read_last
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
