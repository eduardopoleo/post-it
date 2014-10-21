class Category < ActiveRecord::Base
	has_many :post_categories
	has_many :posts, through: :post_categories

  validates :name, presence: true, length: { minimum: 3 }, uniqueness: true

  before_save :generate_slug

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
      slug = remove_ending_dash(slug).downcase
    else
      slug = name.downcase
    end

    counter = 1
    possible_slug = slug

    while Category.find_by_slug(possible_slug)
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