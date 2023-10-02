class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|

      t.integer :follower_id, null: false, default: ""
      t.integer :followee_id, null: false, default: ""
      t.timestamps
    end
  end
end
