class Post < ApplicationRecord
  belongs_to :user
  has_many :habits, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :bads, dependent: :destroy
  has_many :comments, dependent: :destroy
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 300}
  validate :picture_size

  #ユーザーが投稿にグッドをすでにしているかどうか
  def thumbs_up?(user)
    goods.where(user_id: user.id).exists?
  end

  #ユーザーが投稿にバッドをすでにしているかどうか
  def thumbs_down?(user)
    bads.where(user_id: user.id).exists?
  end

  private
    #アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "画像ファイルのサイズは5MB以下にしてください")
      end
    end
end
