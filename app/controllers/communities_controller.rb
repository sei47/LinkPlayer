class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :community_change_check, only: [:edit, :destroy]

  def index
    @q = Community.ransack(params[:search])
    @communities = @q.result(distinct: true)
  end

  def new
    @community = Community.new
  end

  def show
    set_community
    @posts = @community.posts
    @post = @community.posts.build
  end

  def edit
    set_community
  end

  def create
    @community = Community.new(community_params)
    @community.create_user_id = current_user.id
    if @community.save
      @community.community_participation(@community.create_user_id)
      redirect_to community_path(@community), notice: "登録しました"
    else
      flash.now[:danger] = "保存に失敗しました"
      render :new
    end
  end

  # def participation
  #   set_community
  #   @community.community_participation(current_user.id)
  #   redirect_to community_path(@community), notice: "参加しました"
  # end
  #
  # def secession
  #   set_community
  #   @community.community_secession(current_user.id)
  # end

  def update
    set_community
    if @community.update(community_params)
      redirect_to communities_path, notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    set_community
    @community.destroy
    redirect_to communities_path, notice: "削除しました"
  end

  private

  def community_change_check
    set_community
    if @community.create_user_id == current_user or current_user.try(:admin?)
      redirect_to communities_path, notice: "権限がありません"
    end
  end

  def set_community
    @community = Community.find(params[:id])
  end

  def community_params
    params.require(:community).permit(:name, :icon, :comment, :create_user_id, :game_id, {tag_ids: []})
  end
end
