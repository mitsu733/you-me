class AddUserIdToPetRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_records, :user_id, :integer
  end
end
