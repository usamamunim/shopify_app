class ApplicationController < ActionController::Base
  include ShopifyApp::EmbeddedApp
  include ShopifyApp::RequireKnownShop
  include ShopifyApp::ShopAccessScopesVerification
  # skip_before_action :verify_authenticity_token
end
