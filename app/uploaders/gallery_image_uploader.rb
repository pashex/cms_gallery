# encoding: utf-8

class GalleryImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes
  process :set_content_type

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [160, 160]
  end

  version :medium do
    process resize_to_limit: [800, 800]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    'cms_gallery/' + [version_name, 'missing.gif'].compact.join('_')
  end

end
