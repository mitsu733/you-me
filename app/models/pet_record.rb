class PetRecord < ApplicationRecord
	# いいね機能
	has_many :likes, dependent: :destroy

	# タグ
	has_many :record_tags, dependent: :destroy
	has_many :tags, through: :record_tags

	belongs_to :user

	# 投稿画像
	attachment :record_image, destroy: false

	# いいね機能
    def liked_by?(user)
      likes.where(user_id: user.id).exists?
    end

    private
    # タグ機能
    after_create do
	    #1.controller側でcreateしたpet_recordを取得
	    pet_record = PetRecord.find_by(id: self.id)
	    #2.正規表現を用いて、pet_recordのbody内から『#○○○』の文字列を検出
	    tags = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
	    #3.mapメソッドでtags配列の要素一つ一つを取り出して、先頭の#を取り除いてDBへ保存する
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
end
