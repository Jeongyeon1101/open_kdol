class EndUser::TimelineController < ApplicationController
  def index
    @post_contents = PostContent.where(end_user_id: [current_end_user.id, *current_end_user.following_ids])
  end


end
