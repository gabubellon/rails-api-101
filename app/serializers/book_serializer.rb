class BookSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :authors
end
