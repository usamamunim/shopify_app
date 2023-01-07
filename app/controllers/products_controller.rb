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
        new_size = params["#{variant.id}_size"].split('_')[0]
        new_color = params["#{variant.id}_color"].split('_')[0]
        new_price = params["#{variant.id}_price"].split('_')[0]
        variant.option1 = new_size
        variant.option2 = new_color
        variant.price = new_price
      end
      if @product.save
        redirect_to products_path, flash: {message:"Product updated"}
      end
     end
  end
  private
  def set_shop
    @shop_origin = current_shopify_domain
    @shop = Shop.find_by(shopify_domain: @shop_origin)
  end
end
