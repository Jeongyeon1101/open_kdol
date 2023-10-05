class EndUser::PostContentsController < ApplicationController
  def new
    @post_content = PostContent.new
  end

  def index
    if params[:search]
      @search_contents = PostContent.where("text LIKE ? ", '%' + params[:search] + '%').or(EndUser.where("name LIKE ? ", '%' + params[:search] + '%'))
      # 投稿orユーザ検索
    else
      @post_contents = PostContent.all
    end
  end

  def create
    @post_content = PostContent.new(post_content_params)
    @post_content.end_user_id = current_end_user.id
    @post_content.save!
    redirect_to post_contents_path
  end

  def show
    @post_content = PostContent.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post_content = PostContent.find(params[:id])
  end

  def update
    post_content = PostContent.find(params[:id])
    post_content.update(post_content_params)
    redirect_to post_content_path(post_content.id)
  end

  def destroy
    post_content = PostContent.find(params[:id])
    post_content.destroy
    redirect_to post_contents_path
  end

  private

  def post_content_params
    params.require(:post_content).permit(:text, :image)
  end
end
