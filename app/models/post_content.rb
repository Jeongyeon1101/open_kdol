class PostContent< ApplicationRecord
  belongs_to :end_user
  has_one_attached :image
  has_many :likes, dependent: :destroy

  def liked_by?(end_user)
    likes.exists?(end_user_id: end_user.id)
  end

  def get_image(width,height)
    image.variant(resize_to_limit: [width, height]).processed
  end
end
