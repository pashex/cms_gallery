class Gallery < ActiveRecord::Base
  mount_uploader :image, GalleryImageUploader

  has_many :gallery_images, dependent: :destroy

  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
end
