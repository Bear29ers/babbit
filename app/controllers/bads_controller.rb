class BadsController < ApplicationController
  before_action :logged_in_user

  def create
    @post = Post.find_by(id: params[:post_id])
    bad = current_user.bads.build(post_id: @post.id)
    bad.save
    respond_to do |format|
      format.html {redirect_to request.referrer || root_url}
      format.js
    end
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    bad = Bad.find_by(user_id: current_user.id, post_id: @post.id)
    bad.destroy
    respond_to do |format|
      format.html {redirect_to request.referrer || root_url}
      format.js
    end
  end
end
