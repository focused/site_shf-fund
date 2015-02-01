class ProductPhoto < ActiveRecord::Base
  mount_uploader :src, ProductPhotoUploader

  after_destroy :clear_files

  belongs_to :product

  validates :position, numericality: { only_integer: true }

  private

  # delete attached file and its versions if present
  def clear_files
    return if src.current_path.nil?
    FileUtils.rm_rf(File.dirname(self.src.current_path))
  end
end
