# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 # ユーザー
User.create!(
  [
  	{
	  email: "uo@yumex.com",
	  password: "password",
      name: "山本重国",
      pet_name: "うお",
      intoroduction: "白くてかわいい、８歳。"
    },
    {
	  email: "bobo@yumex.com",
	  password: "password",
      name: "ぼ",
      pet_name: "ぱ",
      intoroduction: "ぱ河合"
    },
    {
	  email: "too@yumex.com",
	  password: "password",
      name: "TOO",
      pet_name: "ちゃ",
      intoroduction: "茶色くてお茶目"
    },
    {
	  email: "mai@yumex.com",
	  password: "password",
      name: "mai",
      pet_name: "おは",
      intoroduction: "10歳を過ぎて、色々あったものの元気！"
    },
    {
	  email: "mitsu@yumex.com",
	  password: "password",
      name: "みつお",
      pet_name: "UO",
      intoroduction: "慢性腎臓病、心臓病を患っています。
今はそれなりに元気に過ごしています。
いつかくるその日まで、ここで生きている記録をつけます。


UOが一番好きです。
ずっと一緒にいたいです。"
    }
  ]
)

# きろく
25.times do |pet_record|
  PetRecord.create!(
    user_id: User.all.sample.id,
    toilet: "◯",
    water: "◯",
    food: "◯",
    energy: "◯",
    body: "今日も元気でした。",
    record_public: true
  )
end

# created_atの変更
PetRecord.all.each do |record|
record.update_attribute :created_at, (rand*20).days.ago
end