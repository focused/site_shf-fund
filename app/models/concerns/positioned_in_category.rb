module PositionedInCategory
  extend ActiveSupport::Concern
  include Positioned

  included do
    scope :in_category, -> category { where(product_category_id: category) }
  end

  private

  def get_max_position
    self.class
      .unscoped
      .in_category(product_category_id)
      .maximum(:position).to_i + 1
  end
end
