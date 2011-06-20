require 'spec_helper'

describe "Scalarium.configuration", "when first created" do

  it "should has no api token set yet" do
    Scalarium.configuration.api_token.should == nil
  end

  it "we should be able to set api token and check it's presence" do
    Scalarium.configuration.api_token = "FAKE_TOKEN"
    Scalarium.configuration.api_token.should == "FAKE_TOKEN"
  end
  
end