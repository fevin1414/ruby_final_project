class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  version :thumbnail do
    process resize_to_fit: [100, 100]
  end

  version :product_reference do
    process resize_to_fit: [300, 300]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
