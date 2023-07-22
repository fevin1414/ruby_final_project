class ProductImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  version :thumbnail do
    process resize_to_fit: [100, 100]
  end

  version :left_image do
    process resize_to_fit: [800, 800]
  end

  version :back_image do
    process resize_to_fit: [800, 800]
  end

  version :side_image do
    process resize_to_fit: [800, 800]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
