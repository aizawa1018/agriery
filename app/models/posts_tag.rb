class PostsTag

  include ActiveModel::Model
  attr_accessor :text,:title,:user_id, :name

  with_options presence: true do
    validates :name
    validates :text
    validates :title
    validates :user_id
  end

    def save
      post = Post.create(text: text, title: title,user_id: user_id)
      tag = Tag.where(name: name).first_or_initialize
      tag.save

      PostTagRelation. create(post_id: post.id, tag_id: tag.id)
    end
  end