class Post < ApplicationRecord

  has_one_attached :post_image
  has_one :spot, dependent: :destroy
  accepts_nested_attributes_for :spot
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :post_image, presence: true

  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_post.png')
      post_image.attach(io: File.open(file_path), filename: 'default-post-image.png', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索機能
  def self.search(word)
   @post = Post.where(["title like?", "%#{word}%"])
  end
end
