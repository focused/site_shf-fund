Upmin::Engine.routes.draw do
  resources :products, only: %w(update)

  resources :product_photos, only: %w(create) do
    delete :destroy, on: :collection
  end
end

Rails.application.routes.draw do
  resources :order_items

  mount Upmin::Engine => '/admin'
  mount Ckeditor::Engine => '/ckeditor'

  root "catalog/product_categories#show",
    constraints: -> params, _ { Catalog::ProductCategoryDocument.(params[:path]) }

  # Cart
  get "cart" => "order_items#index"
  resources :order_items, only: %w(index create update destroy)

  # Catalog
  namespace :catalog do
    resources :product_categories, only: %w(show)
  end
  get "*path/:path_id" => "catalog/products#show",
    constraints: -> params, _ { Catalog::ProductDocument.(*params.values_at(:path, :path_id)) }
  get "*path" => "catalog/product_categories#show",
    constraints: -> params, _ { Catalog::ProductCategoryDocument.(params[:path]) }

  # App
  get "*path" => "app/documents#show",
    as: "app_document",
    constraints: -> params, _ { App::StaticDocument.(params[:path]) }
end
