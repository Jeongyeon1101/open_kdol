class CreateReposts < ActiveRecord::Migration[6.1]
  def change
    create_table :reposts do |t|

      t.integer :end_user_id, null: false, default: ""
      t.integer :post_content_id, null: false, default: ""
      t.timestamps
    end
  end
end
