class EndUser::MessagesController < ApplicationController
  before_action :authenticate_end_user!
  def index
    @message = Message.new
    @messages = current_end_user.messages.all
  end

  def create
    @message = Message.new(message_params)
    @message.end_user_id = current_end_user.id
    @message.save!
    redirect_to messages_path
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    message = Message.find(params[:id])
    message.update(message_params)
    redirect_to messages_path
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:message, :idol)
  end
end
