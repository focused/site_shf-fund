Rails.application.routes.draw do

  mount Upmin::Engine => '/admin'
  mount Ckeditor::Engine => '/ckeditor'

  root "web_documents#show"
  get ":path" => "web_documents#show", as: "web_document"
end
