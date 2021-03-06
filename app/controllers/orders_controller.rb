class OrdersController < ApplicationController
	def new
    if logged_in?
		  @order = Order.new
		  @listing = Listing.find(params[:listing_id])
    else
      redirect_to login_path
    end
	end

  def create
  	@listing = Listing.find(params[:listing_id])
  	@order = current_user.purchases.new
  	@order.listing_id = params[:listing_id]
  	@order.merchant_id = @listing.user.id
  	@order.amount = @listing.price
  	if @order.save
      redirect_to new_order_braintree_path(@order)
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end
