class Admin::HomesController < ApplicationController
  before_action :authenticate_admin! 
  def top
    if params[:search_end_users]
      @end_users = EndUser.where("name LIKE ? ", '%' + params[:search_end_users] + '%')
    else
      @end_users = EndUser.all
    end
  end

end
