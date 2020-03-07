class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :show, :edit, :update, :create, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 15)
    else
      @posts = Post.all.paginate(page: params[:page], per_page: 15)
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments
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

  def edit
    @user = current_user
    @post = Post.find(params[:id])
  end

  def update
    @user = current_user
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "投稿を編集しました"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to posts_url
    # redirect_to request.referrer || root_url
    # redirect_back(fallback_location: root_url)
  end

  private
    def post_params
      params.require(:post).permit(:content, :picture)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      flash[:danger] = "別のユーザーの投稿を変更・削除できません"
      redirect_to posts_url if @post.nil?
    end
end
