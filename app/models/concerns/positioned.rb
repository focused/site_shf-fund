module Positioned
  extend ActiveSupport::Concern

  included do
    before_validation :set_position

    scope :ordered, -> { order(:position) }

    validates :position, numericality: { only_integer: true }
  end

  private

  def set_position
    self.position ||= get_max_position
  end

  def get_max_position
    self.class
      .unscoped
      .maximum(:position).to_i + 1
  end
end
