class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      t.integer :end_user_id, null: false, default: ""
      t.string :favorite, null: false, default: ""
      t.string :message, null: false, default: ""
      t.timestamps
    end
  end
end
