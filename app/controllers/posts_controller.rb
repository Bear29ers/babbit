class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def new
    @user = current_user
    @post = current_user.posts.build if logged_in?
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿されました"
      #今後index_urlに変える予定
      redirect_to root_url
    else
      @user = current_user
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
