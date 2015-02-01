class Slide < ActiveRecord::Base
  include Positioned

  mount_uploader :src, SlideUploader

  after_destroy :clear_files

  validates :position, numericality: { only_integer: true }

  private

  # delete attached file and its versions if present
  def clear_files
    return if src.current_path.nil?
    FileUtils.rm_rf(File.dirname(self.src.current_path))
  end
end
