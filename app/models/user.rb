class User < ApplicationRecord
  has_many :listings
  has_many  :sales, class_name: "Order", foreign_key: "merchant_id"
  has_many  :purchases, class_name: "Order", foreign_key: "customer_id"
	has_secure_password(validations: false)
	before_save { self.email = email.downcase if self.email }
  validates :username, uniqueness: { case_sensitive: false, allow_nil: true}
  validates :first_name, :last_name, :email, presence: { message: "is required" }

  with_options unless: :google_signin? do |form|
  	form.validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*[0-9]).{6,}/,
    message: "must be at least 6 characters and include one number and one letter" }, confirmation: true
  	form.validates :date_of_birth, :username, :password, :password_confirmation, presence: { message: "is required" }
  	form.validates :email, format: { with: /\A[^@]+@[^@]+\z/,
    message: "is invalid" }, uniqueness: { case_sensitive: false }
  end

  def self.from_omniauth(auth)
    user = User.find_by(uid: auth[:uid]) || User.new
    user.attributes = {
      provider: auth[:provider],
      uid: auth[:uid],
      email: auth[:info][:email],
      first_name: auth[:info][:first_name],
      last_name: auth[:info][:last_name],
      oauth_token: auth[:credentials][:token],
      oauth_expires_at: auth[:credentials][:expires_at]
    }
    user.save!
    user
  end

  def google_signin?
    !provider.nil?
  end

end
