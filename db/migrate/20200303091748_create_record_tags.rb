class CreateRecordTags < ActiveRecord::Migration[5.2]
  def change
    create_table :record_tags do |t|
      t.integer :tag_id
      t.integer :pet_record_id

      t.timestamps
    end
  end
end
