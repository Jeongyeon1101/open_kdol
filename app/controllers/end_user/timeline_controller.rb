class EndUser::TimelineController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @post_contents = PostContent.where(end_user_id: [current_end_user.id, *current_end_user.following_ids]).order(created_at: :desc)
  end


end
