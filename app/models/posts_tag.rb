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

    def update
      @post = Post.where(id: post_id)
      post = Post.update(text: text, title: title,user_id: user_id)
      tag = Tag.where(name: name).first_or_initialize
      tag.save

      map = PostTagRelation.where(post_id: post_id )
      map.update(post_id: post_id, tag_id: tag.id)
     end

  end