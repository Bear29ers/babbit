class Post < ApplicationRecord
  belongs_to :user
  has_many :goods, dependent: :destroy
  has_many :bads, dependent: :destroy
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 500}
  validate :picture_size

  #ユーザーが投稿にいいねを既にしているかどうか
  def thumbs_up?(user)
    goods.where(user_id: user.id).exists?
  end

  private
    #アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "画像ファイルのサイズは5MB以下にしてください")
      end
    end
end
