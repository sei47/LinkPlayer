class AddClomunToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :destination, :integer
    add_index :messages, :destination
  end
end
