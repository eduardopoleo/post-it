class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories 
  has_many :votes, as: :voteable 

  validates :title, presence: true, length: {minimum: 3}, uniqueness: true
  validates :url, presence: true 
  validates :description, presence: true

  before_save :generate_slug

  def remove_ending_dash(string)
    if string.last.match(/\w/)
      string
    else
      remove_ending_dash(string[0..-2])
    end
  end

  def title_to_slug(title)
    if title.match(/\W/)
      slug = ''

      title.each_char do |char|
        if char.match(/\W/)
          slug += '-'
        else
          slug += char
        end
      end
      slug = remove_ending_dash(slug).downcase
    else
      slug = title.downcase
    end
    

    counter = 1
    possible_slug = slug

    while Post.find_by_slug(possible_slug)
      possible_slug = slug + "-#{counter}"
      counter += 1
    end

    slug = possible_slug
  end

  def generate_slug
    self.slug = title_to_slug(self.title)
  end

  def to_param
    slug
  end

  # def self.find(input)
  #   input.to_i == 0 ? find_by_title(input) : super
  # end

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