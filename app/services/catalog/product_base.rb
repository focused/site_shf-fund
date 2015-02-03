module Catalog
  module ProductBase
    FORMATTERS = {
      wear_pct: -> s { "#{s.to_i}%" }
    }
    Id = -> x { x }

    def main_properties
      present_properties %i(factory factory_country)
    end

    def secondary_properties
      present_properties %i(fabric size wear_pct code warranty)
    end

    private

    def primary_photo
      product.product_photos.first
    end

    def present_properties(keys)
      names  = keys.map &Product.method(:human_attribute_name)
      values = keys.map { |key| (FORMATTERS[key] || Id).(product[key]) }

      names.zip(values)
        .select { |_, v| v.present? }
        .to_h
    end
  end
end
