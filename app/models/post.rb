class Post < ApplicationRecord

  has_one_attached :post_image
  belongs_to :user, dependent: :destroy

  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image_post.png')
      post_image.attach(io: File.open(file_path), filename: 'default-post-image.png', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_limit: [width, height]).processed
  end
end
