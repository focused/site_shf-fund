class ProductPhoto < ActiveRecord::Base
  include Positioned

  alias_attribute :parent_id, :product_id

  mount_uploader :src, ProductPhotoUploader

  after_destroy :clear_dependencies

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
  def clear_dependencies
    return if src.current_path.nil?
    FileUtils.rm_rf(File.dirname(self.src.current_path))
  end

end
