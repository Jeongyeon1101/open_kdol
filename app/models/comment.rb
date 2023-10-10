class Comment < ApplicationRecord
  belongs_to :end_user
  belongs_to :post_content
  has_many :notifications, dependent: :destroy
end
