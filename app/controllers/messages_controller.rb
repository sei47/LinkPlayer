class MessagesController < ApplicationController
  def index
    @friends = current_user.passive_friends
    @messages = current_user.messages unless params[:output]
  end

  def new
    @message = Message.new
    @friends = current_user.active_friends
  end

  def create
    @friend = Friend.where(myself_id: current_user.id).where(partner_id: params[:message][:partner_search])
    @message = Message.new(message_params)
    @message.friend_id = @friend.ids[0]
    @message.user_id = current_user.id
    if @message.save
      # 通知処理
      redirect_to messages_path, notice: "登録しました"
    else
      flash.now[:danger] = "保存に失敗しました"
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:message, :message_image, :friend_id)
  end
end
