require 'rails_helper'

RSpec.describe User, type: :feature do
  before :each do
		@user = User.create(first_name: "Emily", last_name:"Kennedy", email: "emily.kennedy@gmail.com", username: "emken", date_of_birth: "03/03/1995", password: "pa55word", password_confirmation: "pa55word")
	end

	describe "login_path" do
		it "allows user to login" do
			visit login_path
			fill_in("session[email]", with: @user.email)
			fill_in("session[password]", with: @user.password)
  		click_button("Log in")
			expect(page).to have_content(@user.first_name)
		end

		it "displays error if invalid credentials are entered" do
			visit login_path
			fill_in("session[email]", with: @user.email)
			fill_in("session[password]", with: "worng_password")
  		click_button("Log in")
			expect(page).to have_content("Invalid email/password combination")
		end
	end
end