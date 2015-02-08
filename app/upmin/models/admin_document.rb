class AdminDocument < Upmin::Model
  class << self
    def color
      :blue_green
    end
  end

  def deletable?
    !handler.present? && path != "/"
  end
end

