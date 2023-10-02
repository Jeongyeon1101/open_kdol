class PostContent< ApplicationRecord
  belongs_to :end_user
  has_one_attached :image

  def get_image(width,height)
    image.variant(resize_to_limit: [width, height]).processed
  end
end
