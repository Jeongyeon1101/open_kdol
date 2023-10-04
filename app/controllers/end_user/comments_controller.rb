class EndUser::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    post_content = PostContent.find(params[:post_content_id])
    comment = current_end_user.comments.new(comment_params)
    comment.post_content_id = post_content.id
    comment.save
    redirect_to post_content_path(post_content)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_content_path(params[:post_content_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
