# frozen_string_literal: true

class ProductsController < AuthenticatedController
  # include ShopifyApp::EmbeddedApp
  before_action :set_shop
  def index
    @shop.with_shopify_session do
      @products = ShopifyAPI::Product.all
     end
  end

  def edit
    @shop.with_shopify_session do
      @product = ShopifyAPI::Product.find(id: params[:id])
     end
  end

  def update
    @shop.with_shopify_session do
      @product = ShopifyAPI::Product.find(id: params[:id])
      p params
      if params[:title]
        @product.title = params[:title]
      end
      for variant in @product.variants do
        variant.price = params["#{variant.id}"]
      end
      @product.save
     end
  end
  private
  def set_shop
    @shop_origin = current_shopify_domain
    @shop = Shop.find_by(shopify_domain: @shop_origin)
  end
end
