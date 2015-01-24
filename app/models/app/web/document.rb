module App::Web
  class Document < ActiveRecord::Base
    self.table_name = "app_web_documents"
  end
end
