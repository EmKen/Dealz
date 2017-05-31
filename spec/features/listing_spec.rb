require 'rails_helper'

RSpec.describe Listing, type: :feature do
  before :each do
		user = User.create(first_name: "Emily", last_name:"Kennedy", email: "emily.kennedy@gmail.com", username: "emken", date_of_birth: "03/03/1995", password: "pa55word", password_confirmation: "pa55word")
		@listing = user.listings.create(product: "Green chair", price: 100, category: "furniture")
	end

	describe "root_path" do
		it "displays listings" do
			visit root_path
			expect(page).to have_content(@listing.product)
		end
	end
end