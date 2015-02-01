module AppData
  Seed = Struct.new :scope do
    def [](*args, &block)
      method(:call).to_proc.curry[*args, &block]
    end

    def call(scope_attrs, data_attrs)
      scope
        .where(scope_attrs)
        .first_or_create!(data_attrs)
    end
  end
end
