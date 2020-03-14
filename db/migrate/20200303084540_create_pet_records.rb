class CreatePetRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_records do |t|
      t.string :toilet
      t.string :water
      t.string :food
      t.string :energy
      t.string :record_image_id
      t.text :body
      t.boolean :record_public, default: false, null: false

      t.timestamps
    end
  end
end
