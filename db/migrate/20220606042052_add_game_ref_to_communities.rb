class AddGameRefToCommunities < ActiveRecord::Migration[6.0]
  def change
    add_reference :communities, :game, null: false, foreign_key: true
  end
end
