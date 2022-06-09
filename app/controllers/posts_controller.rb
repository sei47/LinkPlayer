class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @community = Community.find(params[:community_id])
    @post = @community.posts.build(post_params)
    @post.user_id = User.find(current_user.id).id
    binding.irb
    respond_to do |format|
      if @post.save
        format.js { render :index }
      else
        format.html { redirect_to community_path(@community), notice: '投稿できませんでした...' }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
