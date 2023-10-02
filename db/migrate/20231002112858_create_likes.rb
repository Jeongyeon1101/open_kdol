class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|

      t.integer :end_user_id, null: false, default: ""
      t.integer :post_id, null: false, default: ""
      t.timestamps
    end
  end
end
