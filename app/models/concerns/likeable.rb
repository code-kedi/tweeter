module Likeable
  extend ActiveSupport::Concern

  included do
    # included do allows us to reuse some logic
    # we can define the associations here
    has_many :likes, as: :likeable
  end

  # helper method
  def liked_by?(user)
    # e.g. tweet.likes.where...
    likes.where(user: user).any?
  end
end
