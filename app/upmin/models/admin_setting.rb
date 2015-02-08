class AdminSetting < Upmin::Model
  class << self
    def color
      :red
    end

    def creatable?
      false
    end
  end

  def deletable?
    false
  end

end

