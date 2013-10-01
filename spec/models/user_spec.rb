require 'spec_helper'

describe User do

  it "is a valid object" do
    user = User.new
    user.name = "Bela"
    user.email = "asd@asd.hu"
    user.should be_valid
  end

  it "is invalid without e-mail address" do
    #FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "is invalid without name" do
    #FactoryGirl.build(:user, name: nil).should_not be_valid
  end
end
