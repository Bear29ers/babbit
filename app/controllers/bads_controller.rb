class BadsController < ApplicationController
  before_action :logged_in_user

  def create
    @post = Post.find_by(id: params[:post_id])
    bad = current_user.bads.build(post_id: @post.id)
    bad.save
    redirect_to request.referrer || root_url
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    bad = Bad.find_by(user_id: current_user.id, post_id: @post.id)
    bad.destroy
    redirect_to request.referrer || root_url
  end
end
