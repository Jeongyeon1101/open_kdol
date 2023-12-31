class EndUser::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @post_content = PostContent.find(params[:post_content_id])
    @comment = current_end_user.comments.new(comment_params)
    @comment.post_content_id = @post_content.id
    if @comment.save
      @post_content.create_notification_comment!(current_end_user, @comment.id)
      redirect_to post_content_path(@post_content)
    else
      render 'end_user/post_contents/show'
    end
  end

  def edit
    is_matching_login_end_user
    @post_content = PostContent.find(params[:post_content_id])
    @comment = Comment.find(params[:id])
  end

  def update
    is_matching_login_end_user
    @post_content = PostContent.find(params[:post_content_id])
    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
    redirect_to post_content_path(params[:post_content_id])
  end

  def destroy
    is_matching_login_end_user
    Comment.find(params[:id]).destroy
    redirect_to post_content_path(params[:post_content_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :image).merge(post_content_id: params[:post_content_id])
  end

  def is_matching_login_end_user
    @comment = Comment.find(params[:id])
    @end_user = @comment.end_user
    unless @end_user.id == current_end_user.id
      redirect_to post_contents_path
    end
  end

end
