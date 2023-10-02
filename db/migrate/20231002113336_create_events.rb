class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|

      t.string :title, null: false, default: ""
      t.string :content, null: false, default: ""
      t.datetime :start_time, null: false, default: ""
      t.timestamps
    end
  end
end
