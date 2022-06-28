class MessagesController < ApplicationController
  def index
    @friends = current_user.passive_friends
    @messages = current_user.messages unless params[:output]
  end

  def new
    @partners = []
    @message = Message.new
    @friends  = current_user.active_friends
    @friends.each do |friend|
      if friend.request
        @partners.push(friend.partner)
      end
    end
  end

  def create
    @friend = Friend.where(myself_id: current_user.id).find_by(partner_id: params[:message][:partner_search])
    @message = Message.new(message_params)
    @message.friend_id = @friend.id
    @message.user_id = current_user.id
    @message.destination = @friend.partner.id
    if @message.save
      redirect_to messages_path, notice: "登録しました"
    else
      @partners = []
      @friends  = current_user.active_friends
      @friends.each do |friend|
        if friend.request
          @partners.push(friend.partner)
        end
      end
      render :new
      # format.html { render :new }
      # flash.now[:danger] = "保存に失敗しました"
    end
  end

  private

  def message_params
    params.require(:message).permit(:message, :message_image, :friend_id, :destination)
  end
end
