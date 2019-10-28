class Image < ApplicationRecord
  belongs_to :user

  mount_uploader :picture, PictureUploader

  validates :width, :height, numericality: { only_integer: true, greater_than: 0, allow_blank: true}
  validates :picture, :user_id, presence: true

  def resize
    image = MiniMagick::Image.open(picture.current_path)
    image.resize "#{width || ''}x#{height || ''}"
  end
end
