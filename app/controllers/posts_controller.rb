class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def index
    @feed_items = current_user.feed.paginate(page: params[:page], per_page: 15)
  end

  def new
    @user = current_user
    @post = current_user.posts.build if logged_in?
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿されました"
      redirect_to posts_url
    else
      @user = current_user
      @feed_items = []
      render 'new'
    end
  end

  def destroy
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
