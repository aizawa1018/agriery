class PostsForm
  include ActiveModel::Model

  # 読み書き許可
  attr_accessor :text,:title, :user_id, :name, :post_id, :tag_id

  # バリデーション
  with_options presence: true do
    validates :name
    validates :text
    validates :title
    validates :user_id
  end

  # レコードに値があるかないかでcreate or updateに分岐させる
  delegate :persisted?, to: :post

  # 初期化
  def initialize(attributes = nil, post: Post.new)
    @post = post
    attributes ||= default_attributes
    super(attributes)
  end


  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      tags = split_tag_names.map { |posts_tag| Tag.find_or_create_by!(name: posts_tag) }
      # => Tag.find_or_create_by!(name: posts_tag)
      # データがない場合
      # Tag.find_or_create_by!(name: "タグ１")
      # <Tag ~ id: nil, name :タグ1, created_at: nil, updated_at: nil > => 新しいインスタンス

      # データがある場合
      # Tag.find_or_create_by!(name: "タグ2")
      # <Tag ~ id: 1, name :タグ2, created_at: 20210819, updated_at: 20210819 > => データを持ってきてインスタンスを作成する
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
    # name = "タグ1,タグ2,タグ3"
    # name.split(',')
    # name = ["タグ1", "タグ2", "タグ3"]
    name.split(',')
  end

end