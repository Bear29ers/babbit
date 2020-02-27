class GoodsController < ApplicationController
  before_action :logged_in_user

  def create
    @post = Post.find_by(id: params[:post_id])
    good = current_user.goods.build(post_id: @post.id)
    good.save
    respond_to do |format|
      format.html {redirect_to request.referrer || root_url}
      format.js
    end
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    good = Good.find_by(user_id: current_user.id, post_id: @post.id)
    good.destroy
    respond_to do |format|
      format.html {redirect_to request.referrer || root_url}
      format.js
    end
  end
end
