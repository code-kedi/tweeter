class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :tweet, optional: true
  # optional: true => if a tweet is created, it doesn't need a tweet_id
  # id != tweet_id !
  has_many :comments
  has_many :likes, as: :likeable

  validates :body, length: { maximum: 240 }, allow_blank: false, unless: :tweet_id
  # if there is a tweet_id, the validation for the body are not applied

  # with the method we signify what types of tweet we want a tweet to be
  # it allows us to later to tweet.tweet_type
  def tweet_type
    if tweet_id? && body?
      'quote-tweet'
    elsif tweet_id?
      'retweet'
    else
      'tweet'
    end
  end
end
