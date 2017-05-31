class BraintreeController < ApplicationController
  def new
  	@order = Order.find(params[:order_id])
  	@listing = @order.listing
  	@price = @listing.price
  	@client_token = Braintree::ClientToken.generate
  end

  def checkout
  	params
	  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
	  @order = Order.find(params[:checkout_form][:order_id])
  	@listing = @order.listing
  	price = @listing.price

	  result = Braintree::Transaction.sale(
	   :amount => price,
	   :payment_method_nonce => nonce_from_the_client,
	   :options => {
	      :submit_for_settlement => true
	    }
	   )

	  if result.success?
	  	@order.processing!
	    redirect_to order_path(@order), :flash => { success: "Payment successful!" }
	  else
	    redirect_to order_path(@order), :flash => { error: "Transaction failed. Please try again." }
	  end 
	end
end
