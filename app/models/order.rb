class Order < ApplicationRecord
	belongs_to	:merchant, class_name: "User"
	belongs_to	:customer, class_name: "User"
	belongs_to	:listing

	enum status: { awaiting_payment: 0, processing: 1, completed: 2, cancelled: 3, refunded: 4 }
end
