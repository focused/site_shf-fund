# encoding: utf-8

class FileUploader < ApplicationUploader

  def extension_white_list
    %w(doc docx xls xlsx ppt pptx pdf txt rtf jpg jpeg gif png)
  end

end
