class TweetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def create
    @tweet = Tweet.new(tweet_params)
    # because a tweet belongs to a user, we need a user_id to save a tweet
    @tweet.user = current_user

    respond_to do |format|
      if @tweet.save
        format.turbo_stream
      else
        format.html do
          flash[:tweet_errors] = @tweet.errors.full_messages
          redirect_to root_path
        end
      end
    end
  end

  def destroy
    @tweet = current_user.tweets.find(params[:id])
    @tweet.destroy
  end

  def retweet
    @tweet = Tweet.find(params[:id])
    @retweet = current_user.tweets.new(tweet_id: @tweet.id)
    # we create a new tweet (retweet) based on the current user who is retweeting
    # and passing the tweet_id of the original tweet
    # if we had retweet instead of @retweet, it would be a local variable
    # by doing @retweet, we have an instance variable

    respond_to do |format|
      if @retweet.save
        format.turbo_stream
      else
        format.html { redirect_back fallback_location: @tweet, alert: 'Could not retweet' }
      end
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body, :tweet_id)
  end
end
