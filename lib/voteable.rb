module Voteable
  extend ActiveSupport::Concern

  included do 
    has_many :votes, as: :voteable
  end

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