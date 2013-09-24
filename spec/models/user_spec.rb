require 'spec_helper'
require 'factory_girl'

describe User do

  it "has a valid Factory object" do
    FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without e-mail address" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "is invalid without name" do
    FactoryGirl.build(:user, name: nil).should_not be_valid
  end
end
