class LikesController < ApplicationController
  before_action :set_likeable

  def create
    if @likeable.likes.count >= 1 && @likeable.liked_by?(current_user)
      # if it's liked you want to be able to unlike it
      @like = Like.find_by(likeable_id: @likeable.id, user: current_user)
      @like.destroy
    else
      # when you like a tweet, you can only like it once
      @like = @likeable.likes.new
      @like.user = current_user
      @like.save!
    end
  end

  private

  def set_likeable
    @likeable = params[:likeable_type].constantize.find(params[:likeable_id])
    # params[:likeable_type].constantize will turn into a class name, e.g. Tweet.find()
  end
end
