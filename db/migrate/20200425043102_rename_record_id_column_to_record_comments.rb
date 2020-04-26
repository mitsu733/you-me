class RenameRecordIdColumnToRecordComments < ActiveRecord::Migration[5.2]
  def change
  rename_column :record_comments, :record_id, :pet_record_id
  end
end
