class Tag < ApplicationRecord
	has_many :record_tags, dependent: :destroy
	has_many :pet_records, through: :record_tags
end

