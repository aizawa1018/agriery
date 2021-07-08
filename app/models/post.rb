class Post < ApplicationRecord
  has_many   :post_tag_relations,foreign_key: :post_id, dependent: :destroy
  has_many   :tags, through: :post_tag_relations
  has_many   :comment
  belongs_to :user
end
