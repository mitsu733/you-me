class CreateRecordComments < ActiveRecord::Migration[5.2]
  def change
    create_table :record_comments do |t|
      t.string :comment
      t.integer :user_id
      t.integer :record_id

      t.timestamps
    end
  end
end
