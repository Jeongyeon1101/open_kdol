class Comment < ApplicationRecord
  has_one_attached :image
  belongs_to :end_user
  belongs_to :post_content
  has_many :notifications, dependent: :destroy

  def get_image(width,height)
    image.variant(resize_to_limit: [width, height]).processed
  end
end
