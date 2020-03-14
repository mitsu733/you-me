class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # デバイス
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 投稿
  has_many :pet_records, dependent: :destroy
  # いいね機能
  has_many :likes, dependent: :destroy
  has_many :like_pet_records, through: :likes, source: :pet_record
  # フォロー
  has_many :active_relationships, class_name: "UserRelationship", foreign_key: :followed_id
  has_many :followeds, through: :active_relationships, source: :follower
  has_many :passive_relationships, class_name: "UserRelationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :followed
  # プロフィール画像
  attachment :profile_image, destroy: false

  enum user_status: { "公開"=>0, "非公開"=>1}

  # フォロー
  def followed_by?(user)
    passive_relationships.find_by(followed_id: user.id).present?
  end

  
end
