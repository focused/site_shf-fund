# deprecated???
class AdminProductPhoto < Upmin::Model
  class << self
    def items_per_page
      30
    end

    def color
      :yellow
    end
  end

  def parent_association?(association)
    association.type == :product
  end
end

