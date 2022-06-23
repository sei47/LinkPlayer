class FriendsController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js

  def index
    @friends = current_user.active_friends
  end

  def new
    @users = User.all
    @users = @users.where('name LIKE ?', "%#{params[:name_search]}%") if params[:name_search].present?
  end

  def create
    @user = User.find(params[:friend][:partner_id])
    current_user.friend_request!(@user)
  end

  def accept
    @friend = Friend.find(params[:request_id])
    @user = User.find(@friend.myself_id)
    @friend.request = true
    @friend.save
    current_user.friend_accept!(@user)
    redirect_to user_path(current_user.id)
  end

  def destroy
    @request = Friend.find(params[:id])
    if @request.request?
      @user = @request.partner
      current_user.elimination(@user)
    else
      @user = @request.myself
      current_user.unfriend(@user)
    end
    redirect_to user_path(current_user.id)
  end

  private

  def friend_params
    params.permit(:myself_id, :partner_id)
  end
end
