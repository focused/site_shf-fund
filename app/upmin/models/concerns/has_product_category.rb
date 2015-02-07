module HasProductCategory
  extend ActiveSupport::Concern

  def breadcrumbs(parent_id = nil)
    Breadcrumbs[get_parent(parent_id)].(method(:upmin_model_path))
  end

  def get_parent(id = nil)
    id ? ProductCategory.find_by(id: id) : product_category
  end

  def parent_association?(association)
    association.type == :product_category
  end

  private

  Breadcrumbs = Struct.new :parent do
    def call(url_helper)
      [root, parent].compact.map(&breadcrumbs_item(url_helper))
    end

    private

    def root
      parent && parent.product_category
    end

    def breadcrumbs_item(url_helper)
      -> m { [m.name, url_helper.(klass: ProductCategory, id: m.id)] }
    end
  end
end
