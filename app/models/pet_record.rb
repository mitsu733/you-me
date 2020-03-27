class PetRecord < ApplicationRecord

	# バリデーション
	with_options presence: true do
	    validates :toilet
	    validates :water
	    validates :food
	    validates :energy
	end

 	validate :record_public_conditions

	# いいね機能のアソシエーション
	has_many :likes, dependent: :destroy
	has_many :like_users, through: :likes, source: :user

	# タグ機能のアソシエーション
	has_many :record_tags, dependent: :destroy
	has_many :tags, through: :record_tags

	belongs_to :user

	# 投稿画像の設定
	attachment :record_image, destroy: false

	# いいね機能
    def liked_by?(user)
      likes.where(user_id: user.id).exists?
    end


    private

    # タグ機能の設定
    after_create do
	    pet_record = PetRecord.find_by(id: self.id)
	    tags = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
	    tags.uniq.map do |t|
	      tag = Tag.find_or_create_by(tag: t.gsub('＃', "#").delete("#"))
	      pet_record.tags << tag
	    end
  	end

  	before_update do
	    pet_record = PetRecord.find_by(id: self.id)
	    pet_record.tags.clear
	    tags = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
	    tags.uniq.map do |t|
	      tag = Tag.find_or_create_by(tag: t.gsub('＃', "#").delete("#"))
	      pet_record.tags << tag
	    end
	end

	def record_public_conditions
	 	if body.blank? && record_image.blank? && record_public == true
	 	   errors.add(:record_public, "をするためには文字か画像の入力が必要です")
	 	end
	end

end
