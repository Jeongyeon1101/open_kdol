class EndUser::LikesController < ApplicationController
  before_action :authenticate_end_user!
  def create
    @post_content = PostContent.find(params[:post_content_id])
    like = current_end_user.likes.new(post_content_id: @post_content.id)
    like.save
    @post_content.create_notification_like(current_end_user)
    #redirect_to post_content_path(post_content) 非同期通信化の為リダイレクト先を削除　
  end

  def destroy
    @post_content = PostContent.find(params[:post_content_id])
    like = current_end_user.likes.find_by(post_content_id: @post_content.id)
    like.destroy
    #redirect_to post_content_path(post_content) 非同期通信化の為リダイレクト先を削除　
  end

end
