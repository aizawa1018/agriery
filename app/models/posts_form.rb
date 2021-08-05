class PostsForm

  include ActiveModel::Model
  attr_accessor :text,:title,:user_id, :name, :post_id

  with_options presence: true do
    validates :name
    validates :text
    validates :title
    validates :user_id
  end

  delegate :persisted?, to: :post

  def initialize(attributes = nil, post: Post.new)
    @post = post
    attributes ||= default_attributes
    super(attributes)
  end


    def save
      return if invalid?

      ActiveRecord::Base.transaction do
        tags = split_tag_names.map { |posts_tag| Tag.find_or_create_by!(posts_tag: posts_tag) }
        post.update!(title: title, text: text, name: name)
      end
    rescue ActiveRecord::RecordInvalid
      false
    end

    def to_model
      post
    end

    private

    attr_reader :post
    def default_attributes
      {
        title: post.title,
        text: post.text,
        name: post.tags.pluck(:name).join(',')
      }
    end

    def split_tag_names
      post.split(',')
    end


      #post = Post.create(text: text, title: title,user_id: user_id)
      #tag = Tag.where(name: name).first_or_initialize
      #tag.save

      #PostTagRelation. create(post_id: post.id, tag_id: tag.id)
    end

    #def update
      #@post = Post.where(id: post_id)
      #post = Post.update(text: text, title: title,user_id: user_id)
      #tag = Tag.where(name: name).first_or_initialize
      #tag.save

      #map = PostTagRelation.where(post_id: post_id )
      #map.update(post_id: post_id, tag_id: tag.id)
     #end

  