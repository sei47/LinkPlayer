class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.message_read_create(@user)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @request = @user.passive_friends.where(request: false)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin_flag)
  end
end
