class EndUser::FollowsController < ApplicationController
  before_action :authenticate_end_user!
  def create
    @end_user = EndUser.find(params[:end_user_id])
    current_end_user.follow(@end_user)
    @end_user.create_notification_follow!(current_end_user)
    #redirect_to request.referer 非同期通信化の為リダイレクト先を削除
  end

  def destroy
    @end_user = EndUser.find(params[:end_user_id])
    current_end_user.unfollow(@end_user)
    #redirect_to  request.referer 非同期通信化の為リダイレクト先を削除
  end

  def followings
    end_user = EndUser.find(params[:end_user_id])
    @end_users = end_user.followings
  end

  def followers
    end_user = EndUser.find(params[:end_user_id])
    @end_users = end_user.followers
  end
end
