Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  mount Ckeditor::Engine => '/ckeditor'

  # Catalog
  namespace :catalog do
    resources :product_categories, only: %w(show)
  end

  # App
  get "*path" => "app/documents#show",
    as: "app_document",
    constraints: -> params, _ { App.any_document?(params[:path]) }

  # Catalog
  root "catalog/product_categories#show"
  get "*path" => "catalog/product_categories#show",
    constraints: -> params, _ { Catalog.any_document?(params[:path]) }
    # as: "catalog_product_category",
end
