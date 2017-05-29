class User < ApplicationRecord
	has_secure_password
	before_save { self.email = email.downcase }
	validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*[0-9]).{6,}/,
  message: "must be at least 6 characters and include one number and one letter" }, confirmation: true
	validates :first_name, :last_name, :email, :date_of_birth, :username, :password, :password_confirmation, presence: { message: "is required" }
	validates :email, format: { with: /\A[^@]+@[^@]+\z/,
  message: "is invalid" }, uniqueness: { case_sensitive: false, message: "has been taken"}
  validates :username, uniqueness: { case_sensitive: false, message: "has been taken"}
end
