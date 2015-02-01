class ProductPhoto < ActiveRecord::Base
  include Positioned

  mount_uploader :src, ProductPhotoUploader

  after_destroy :clear_files

  belongs_to :product

  scope :in_parent, -> product { where(product: product) }

  validates :src, presence: true

  private

  def get_max_position
    self.class
      .unscoped
      .in_parent(product)
      .maximum(:position).to_i + 1
  end

  # delete attached file and its versions if present
  def clear_files
    return if src.current_path.nil?
    FileUtils.rm_rf(File.dirname(self.src.current_path))
  end
end
