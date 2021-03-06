class ListingsController < ApplicationController

	def index
    @listings = Listing.search(params[:search]).paginate(per_page: 6, page: params[:page])
	end

	def new
		if logged_in?
			@listing = Listing.new
		else
			redirect_to login_path
		end
	end

  def create
  	@listing = current_user.listings.new(listing_params)
    if @listing.save
      redirect_to @listing
    else
      @errors = @listing.errors.full_messages
      render 'new'
    end
  end

  def show
    @listing = Listing.find(params[:id])
    @order = Order.new
  end

  private

  def listing_params
    params.require(:listing).permit(:product, :description, :category, :price)
  end

end
