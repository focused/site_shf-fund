module ApplicationHelper
  def page_title
    content_for(:title) || t("app.name")
  end
end
