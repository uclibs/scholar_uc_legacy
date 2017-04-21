class CreateCollectionAvatars < ActiveRecord::Migration
  def change
    create_table :collection_avatars do |t|
      t.string :collection_id
      t.string :avatar
    end
    add_index :collection_avatars, :collection_id, unique: true
  end
end
