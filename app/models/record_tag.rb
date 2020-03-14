class RecordTag < ApplicationRecord
	belongs_to :pet_record
	belongs_to :tag
end

