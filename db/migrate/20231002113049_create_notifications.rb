class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|

      t.integer :visited_id, null: false, default: ""
      t.integer :visitor_id, null: false, default: ""
      t.integer :post_content_id, default: ""
      t.integer :comment_id, default: ""
      t.string :action, null: false, default: ""
      t.boolean :checked, null: false, default: false
      t.timestamps
    end
  end
end
