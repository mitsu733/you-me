class RecordComment < ApplicationRecord
  validates :comment, length: { in: 1..100 }

  belongs_to :user
  belongs_to :pet_record

end
