require 'spec_helper'

describe User do

  describe "validations" do
    before(:each) { @user = FactoryGirl.build(:user) }

    it "should be valid" do
      expect(@user).to be_valid
    end

    it "should not be valid with password shorter than 6 chars" do
      @user.password = "pass"
      expect(@user).to_not be_valid
    end

    it "should not be valid without a username" do
      @user.username = " "
      expect(@user).to_not be_valid
    end

    it "should not be valid without an email" do
      @user.email = " "
      expect(@user).to_not be_valid
    end

    it "should have a session token" do
      @user.valid?
      expect(@user.session_token).to_not be_nil
    end

    it "should have a password digest" do
      expect(@user.password_digest).to_not be_nil
    end
  end
end
