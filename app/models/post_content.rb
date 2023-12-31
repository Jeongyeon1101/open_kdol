class PostContent< ApplicationRecord
  validates :text, presence: true
  belongs_to :end_user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def liked_by?(end_user)
    likes.exists?(end_user_id: end_user.id)
  end

  def get_image(width,height)
    image.variant(resize_to_limit: [width, height]).processed
  end

  #以下通知機能
  #いいね通知
  def create_notification_like(current_end_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_content_id = ? and action = ? ", current_end_user.id, end_user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_end_user.active_notifications.new(
        post_content_id: id,
        visited_id: end_user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  #コメント通知
  def create_notification_comment!(current_end_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:end_user_id).where(post_content_id: id).where.not(end_user_id: current_end_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_end_user, comment_id, temp_id['end_user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_end_user, comment_id, end_user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_end_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_end_user.active_notifications.new(
      post_content_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
     # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end



