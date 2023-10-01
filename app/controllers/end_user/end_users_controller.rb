class EndUser::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])
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

  def end_user_params
    params.require(:end_user).permit(:profile_image, :name, :introduction, :is_active)
  end
end
