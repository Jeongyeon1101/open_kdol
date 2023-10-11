class EndUser::LikesController < ApplicationController
  def create
    post_content = PostContent.find(params[:post_content_id])
    like = current_end_user.likes.new(post_content_id: post_content.id)
    like.save
    create_notification_like(current_end_user)
    redirect_to post_content_path(post_content)
  end

  def destroy
    post_content = PostContent.find(params[:post_content_id])
    like = current_end_user.likes.find_by(post_content_id: post_content.id)
    like.destroy
    redirect_to post_content_path(post_content)
  end

end
