require 'spec_helper'

describe Site do

  describe "validations" do
    before(:each) { @site = FactoryGirl.build(:site) }

    it "should be valid" do
      expect(@site).to be_valid
    end

    it "should not be valid without a title" do
      @site.title = " "
      expect(@site).to_not be_valid
    end

    it "should not be valid without a description" do
      @site.description = " "
      expect(@site).to_not be_valid
    end

    it "should not be valid without a price" do
      @site.price = nil
      expect(@site).to_not be_valid
    end

    it "should not be valid without a size" do
      @site.size = nil
      expect(@site).to_not be_valid
    end
  end
end
