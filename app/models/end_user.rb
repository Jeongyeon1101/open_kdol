class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_contents, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :profile_image

  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  #1(本人):N(本人がフォローしているユーザ)
  has_many :passive_follows, class_name: "Follow", foreign_key: "followee_id", dependent: :destroy
  #1(本人):N(本人がフォローされているユーザ)
  has_many :followings, through: :active_follows, source: :followee
  #本人がフォローしているユーザ(followee)
  has_many :followers, through: :passive_follows, source: :follower
  #本人がフォローされているユーザ(follower)
  def follow(end_user)
    active_follows.create(followee_id: end_user.id)
  end
  #end_user.idのユーザをフォローする
  def unfollow(end_user)
    active_follows.find_by(followee_id: end_user.id).destroy
  end
  #end_user.idのユーザのフォローを解除する
  def following?(end_user)
    followings.include?(end_user)
  end
  #end_user.idのユーザをフォローしているか確認する



  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
# プロフィール画像を設定していない場合にデフォルトでno_imageが表示される