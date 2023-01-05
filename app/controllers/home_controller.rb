# frozen_string_literal: true

class HomeController < ApplicationController
  include ShopifyApp::EmbeddedApp
  include ShopifyApp::RequireKnownShop
  include ShopifyApp::ShopAccessScopesVerification

  before_action :set_shop

  def index
    @host = params[:host]
    @shop.with_shopify_session do
     @products = ShopifyAPI::Product.all
    end
  end


  private

  def set_shop
    @shop_origin = current_shopify_domain
    @shop = Shop.find_by(shopify_domain: @shop_origin)
  end
end
