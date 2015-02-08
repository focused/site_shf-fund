class AdminOrder < Upmin::Model
  class << self
    def color
      :orange
    end

    def creatable?
      false
    end
  end

  def deletable?
    false
  end

  def state_key
    model.state
  end

  # def state
  #   return Upmin::Widget::ProgressBar.new(model.status, model.tracking_states)
  # end
end

