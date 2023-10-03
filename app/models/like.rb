class Like < ApplicationRecord
  belongs_to :end_user
  belongs_to :post_content
end
