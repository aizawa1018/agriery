class Tag < ApplicationRecord
  has_many :post_tag_relations,foreign_key: :post_id, dependent: :destroy
  has_many :posts, through: :post_tag_relations
  validates :name, uniqueness: true
end
