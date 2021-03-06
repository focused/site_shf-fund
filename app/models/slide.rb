class Slide < ActiveRecord::Base
  include Positioned

  alias_attribute :parent_id, :position

  mount_uploader :src, SlideUploader

  after_destroy :clear_files

  private

  # delete attached file and its versions if present
  def clear_files
    return if src.current_path.nil?
    FileUtils.rm_rf(File.dirname(self.src.current_path))
  end

end
