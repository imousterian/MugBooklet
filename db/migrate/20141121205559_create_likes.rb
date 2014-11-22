class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :like, default: false

      t.timestamps
    end
    add_index :likes, [:user_id, :post_id]
  end
end
