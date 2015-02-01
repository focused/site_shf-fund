Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  mount Ckeditor::Engine => '/ckeditor'

  # Catalog
  namespace :catalog do
    resources :product_categories, only: %w(show)
  end

  # App
  root "app/documents#show"
  get ":path/(:path_id)" => "app/documents#show", as: "app_document"
end
