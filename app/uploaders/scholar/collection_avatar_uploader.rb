# frozen_string_literal: true
class Scholar::CollectionAvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::Compatibility::Paperclip

  version :medium do
    process resize_to_limit: [300, 300]
  end

  version :featured do
    process resize_to_fill: [270, 270]
  end

  def extension_whitelist
    %w(jpg jpeg png gif bmp tif tiff)
  end
end
