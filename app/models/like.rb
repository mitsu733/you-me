class Like < ApplicationRecord
	belongs_to :pet_record
	belongs_to :user
end
