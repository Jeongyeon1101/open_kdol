class EndUser::MessagesController < ApplicationController
  def index
    @message = Message.new
    @messages = current_end_user.messages.all
  end

  def create
    @message = Message.new(message_params)
    @message.save!
    redirect_to messages_path
  end

  def edit
    @message = Message.find(params[:id])
  end

  def update
    message = Message.find(params[:id])
    message.update(message_params)
    redirect_to message_path(message.id)
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy
    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
