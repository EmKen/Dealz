class Order < ApplicationRecord
	belongs_to	:merchant, class_name: "User"
	belongs_to	:customer, class_name: "User"
	belongs_to	:listing
end
