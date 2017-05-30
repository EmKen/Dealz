class Listing < ApplicationRecord
	belongs_to :user
	validates :product, :price, :category, presence: {message: "is required"}

	enum status: { for_sale: 0, sold: 1 }

end
