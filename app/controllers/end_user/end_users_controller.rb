class EndUser::EndUsersController < ApplicationController
  before_action :set_end_user, only: [:likes]

  def likes
    likes = Like.where(end_user_id: @end_user.id).pluck(:post_content_id)
    @like_post_contents = PostContent.find(likes)
  end

  def index
    if params[:search_end_users]
      @end_users = EndUser.where("name LIKE ? ", '%' + params[:search_end_users] + '%')
    else
      @end_users = EndUser.all
    end
  end

  def show
    @end_user = EndUser.find(params[:id])
    @random_message = Message.offset( rand(Message.count) ).first
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    end_user = EndUser.find(params[:id])
    end_user.update(end_user_params)
    redirect_to end_user_path(end_user.id)
  end

  def withdraw
    @end_user = current_end_user
    @end_user.update(is_active: false)
    reset_session
    flash[:notice] = "ありがとうございました。またいつでも遊びに来てください。"
    redirect_to root_path
  end

  private

  def set_end_user
    @end_user = EndUser.find(params[:id])
  end

  def end_user_params
    params.require(:end_user).permit(:profile_image, :name, :introduction, :is_active)
  end
end
