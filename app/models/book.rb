class Book < ApplicationRecord
  has_many :books_authors
  has_many :authors, through: :books_authors
end
