class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
  has_many :votes

  has_secure_password validations: false
  validates :name, presence: true, length: {minimum: 3}, uniqueness: :true
  validates :password, presence: true, on: :create, length: {minimum: 8}

  before_save :generate_slug

# Code related to role
  def admin?
    self.role == "admin"
  end

#Code related to slugging
  def remove_ending_dash(string)
    if string.last.match(/\w/)
      string
    else
      remove_ending_dash(string[0..-2])
    end
  end

  def name_to_slug(name)
    if name.match(/\W/)
      slug = ''

      name.each_char do |char|
        if char.match(/\W/)
          slug += '-'
        else
          slug += char
        end
      end
      slug = remove_ending_dash(slug.downcase)
    else
      slug = name.downcase
    end

    counter = 1
    possible_slug = slug

    while User.find_by_slug(possible_slug)
      possible_slug = slug + "-#{counter}"
      counter += 1
    end

    slug = possible_slug
  end

  def generate_slug
    self.slug = name_to_slug(self.name)
  end

  def to_param
    slug
  end
end