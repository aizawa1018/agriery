class PostsForm

  include ActiveModel::Model
  attr_accessor :text,:title, :user_id, :name, :post_id, :tag_id

  with_options presence: true do
    validates :name
    validates :text
    validates :title
    validates :user_id
  end

  # レコードに値があるかないかでcreate or updateに分岐させる
  delegate :persisted?, to: :post

  def initialize(attributes = nil, post: Post.new)
    @post = post
    attributes ||= default_attributes
    super(attributes)
  end


  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      tags = split_tag_names.map { |posts_tag| Tag.find_or_create_by!(name: posts_tag) }
      post.update!(title: title, text: text, tags: tags, user_id: user_id)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def to_model
    post
  end

  private

  attr_reader :post, :tag

  def default_attributes
    {
      title: post.title,
      text: post.text,
      name: post.tags.pluck(:name).join(',')
    }
  end

  def split_tag_names
    name.split(',')
  end

end