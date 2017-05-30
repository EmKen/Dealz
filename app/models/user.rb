class User < ApplicationRecord
  has_many :listings
	has_secure_password(validations: false)
	before_save { self.email = email.downcase }
  validates :username, uniqueness: { case_sensitive: false, message: "has been taken"}
  validates :first_name, :last_name, :email, presence: { message: "is required" }

  with_options unless: :google_signin? do |form|
  	form.validates :password, format: { with: /(?=.*[a-zA-Z])(?=.*[0-9]).{6,}/,
    message: "must be at least 6 characters and include one number and one letter" }, confirmation: true
  	form.validates :date_of_birth, :username, :password, :password_confirmation, presence: { message: "is required" }
  	form.validates :email, format: { with: /\A[^@]+@[^@]+\z/,
    message: "is invalid" }, uniqueness: { case_sensitive: false, message: "has been taken"}
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def google_signin?
    provider == "google_oauth2"
  end

end
