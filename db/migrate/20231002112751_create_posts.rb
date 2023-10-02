class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|

      t.integer :end_user_id, null: false, default: ""
      t.text :text, null: false, default: ""
      t.timestamps
    end
  end
end
