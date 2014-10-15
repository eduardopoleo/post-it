class Comment < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post
  has_many :votes, as: :voteable

  #validates :body, presence: true, length: { minimum: 3 }

  def total_value
    (positive_votes - negative_votes)
  end

  def positive_votes
    self.votes.where(vote: true).size
  end

  def negative_votes
    self.votes.where(vote: false).size
  end
end 