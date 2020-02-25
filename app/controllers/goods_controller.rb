class GoodsController < ApplicationController
  def create
    good = current_user.goods.build(post_id: params[:post_id])
    good.save
    redirect_to post_path(good.post_id)
  end

  def destroy
    good = Good.find_by(user_id: current_user.id, post_id: params[:post_id])
    good.destroy
    redirect_to post_path(good.post_id)
  end
end
