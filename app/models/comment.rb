class Comment < ApplicationRecord
  # we replaced "has_many :likes, as: :likeable" with the line below
  include Likeable
  belongs_to :user
  belongs_to :tweet
end
