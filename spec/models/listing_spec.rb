require 'rails_helper'

RSpec.describe Listing, type: :model do
  context "validations" do

    describe "validates presence of product, price and category" do
      it { should validate_presence_of(:product).with_message(/is required/) }
      it { should validate_presence_of(:price).with_message(/is required/) }
      it { should validate_presence_of(:category).with_message(/is required/) }
    end
  end


  describe "search" do
  	before :each do
  		user = User.create(first_name: "Emily", last_name:"Kennedy", email: "emily.kennedy@gmail.com", username: "emken", date_of_birth: "03/03/1995", password: "pa55word", password_confirmation: "pa55word")
  		@green_chair = user.listings.create(product: "Green chair", price: 100, category: "furniture")
  		@green_sofa = user.listings.create(product: "Green sofa", price: 100, category: "furniture")
  		@blue_chair = user.listings.create(product: "Blue chair", price: 100, category: "furniture")
  	end

  	it "returns listings that match search criteria" do
  		expect(Listing.search("Green")).to include(@green_chair, @green_sofa)
  	end

  	it "does not return listings which do not match search criteria" do
  		expect(Listing.search("Green")).not_to include(@blue_chair)
  	end
  end

end