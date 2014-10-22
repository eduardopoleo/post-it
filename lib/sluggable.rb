module Sluggable 
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug
    class_attribute :slug_column 
  end
  
  def generate_slug
    self.slug = sluggable_to_slug(self.send(self.class.slug_column.to_sym))
  end

  def sluggable_to_slug(sluggable)
    if sluggable.match(/\W/)
      slug = ''

      sluggable.each_char do |char|
        if char.match(/\W/)
          slug += '-'
        else
          slug += char
        end
      end
      slug = remove_ending_dash(slug).downcase
    else
      slug = sluggable.downcase
    end
    
    counter = 1
    possible_slug = slug

    while self.class.find_by_slug(possible_slug)
      possible_slug = slug + "-#{counter}"
      counter += 1
    end

    slug = possible_slug
  end

  def remove_ending_dash(string)
    if string.last.match(/\w/)
      string
    else
      remove_ending_dash(string[0..-2])
    end
  end

  def to_param
    slug
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end