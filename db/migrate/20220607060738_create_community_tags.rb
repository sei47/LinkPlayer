class CreateCommunityTags < ActiveRecord::Migration[6.0]
  def change
    create_table :community_tags do |t|
      t.references :community, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
