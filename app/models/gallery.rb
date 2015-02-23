class Gallery < ActiveRecord::Base
  mount_uploader :image, GalleryImageUploader

  has_many :gallery_images, dependent: :destroy
end
