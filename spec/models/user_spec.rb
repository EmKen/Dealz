require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do


    describe "validates presence of first name, last name and email" do
      it { should validate_presence_of(:email).with_message(/is required/) }
      it { should validate_presence_of(:first_name).with_message(/is required/) }
      it { should validate_presence_of(:last_name).with_message(/is required/) }
    end

    describe "validates uniqueness of username"
      it { should validate_uniqueness_of(:username).case_insensitive }
    end

    describe "validates password" do
      it { should validate_presence_of(:password).with_message(/is required/) }
      it { should validate_presence_of(:password_confirmation).with_message(/is required/) }
      it { should allow_value("pa55word").for(:password) }
      it { should_not allow_value("password").for(:password) }
      it { should_not allow_value("123456").for(:password) }
      it { should_not allow_value("abc1").for(:password) }
      it { should validate_confirmation_of(:password) }
    end




  context "self.from_omniauth" do
    # happy path
    it "creates or updates user from a valid oauth hash" do
      auth = {
        provider: "google",
        uid: "12345678910",
        info: {
          email: "emily.kennedy@googlemail.com",
          first_name: "Emily",
          last_name: "Kennedy"
        },
        credentials: {
          token: "qwerty123",
          refresh_token: "qwert123",
          expires_at: "2017-05-31 12:37:18"
        }
      }
      User.from_omniauth(auth)
      new_user = User.first

      expect(new_user.provider).to eq("google")
      expect(new_user.uid).to eq("12345678910")
      expect(new_user.email).to eq("emily.kennedy@googlemail.com")
      expect(new_user.first_name).to eq("Emily")
      expect(new_user.last_name).to eq("Kennedy")
      expect(new_user.oauth_token).to eq("qwerty123")
      expect(new_user.oauth_expires_at).to eq("2017-05-31 12:37:18")
    end
    # unhappy path
    it "doesn't create or update user from an incomplete oauth hash" do
      auth = {
        provider: "google",
        uid: "12345678910",
        info: {
          email: "emily.kennedy@googlemail.com",
          first_name: "Emily",
          last_name: "Kennedy"
        },
      }
      expect{User.from_omniauth(auth)}.to raise_error(NoMethodError)
    end
  end
end