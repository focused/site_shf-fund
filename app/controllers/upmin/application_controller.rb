module Upmin
  class ApplicationController < ActionController::Base
    unless Rails.env.development? || Rails.env.test?
      http_basic_authenticate_with name: "furniture", password: "FF9035"
    end
  end
end
