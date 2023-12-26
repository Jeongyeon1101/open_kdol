class DropReposts < ActiveRecord::Migration[6.1]
  def change
     drop_table :reposts do |t|

      t.integer :end_user_id, null: false
      t.integer :post_content_id, null: false
      t.timestamps
    end
  end
end
