class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :end_user_id, null: false, default: ""
      t.text :message, null: false, default: ""
      t.timestamps
    end
  end
end
