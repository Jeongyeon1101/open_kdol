class EndUser::PostContentsController < ApplicationController
  before_action :authenticate_end_user!, only: [:new, :create, :edit, :update, :destroy]
  def new
    @post_content = PostContent.new
  end

  def index
    if params[:search_post_contents]
      @post_contents = PostContent.where("text LIKE ? ", '%' + params[:search_post_contents] + '%')
      # 投稿orユーザ検索
    else
      @post_contents = PostContent.all.order(created_at: :desc)
    end
  end

  def create
    @post_content = PostContent.new(post_content_params)
    @post_content.end_user_id = current_end_user.id
    if @post_content.save
      redirect_to post_contents_path
    else
      render :new
    end
  end

  def show
    @post_content = PostContent.find(params[:id])
    @end_user = @post_content.end_user
    @comment = Comment.new
  end

  def edit
    is_matching_login_end_user
    @post_content = PostContent.find(params[:id])
  end

  def update
    is_matching_login_end_user
    @post_content = PostContent.find(params[:id])
    @post_content.update(post_content_params)
    redirect_to post_content_path(@post_content.id)
  end

  def destroy
    is_matching_login_end_user
    post_content = PostContent.find(params[:id])
    post_content.destroy
    redirect_to post_contents_path
  end

  private

  def post_content_params
    params.require(:post_content).permit(:text, :image)
  end

  def is_matching_login_end_user
    @post_content = PostContent.find(params[:id])
    @end_user = @post_content.end_user
    unless @end_user.id == current_end_user.id
      redirect_to post_contents_path
    end
  end
end
