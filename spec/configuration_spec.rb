require 'spec_helper'

describe "Scalarium.configuration", "when first created" do

  before(:all) do
    Scalarium.configuration.api_token = nil
  end

  it "should has no api token set yet" do
    Scalarium.configuration.api_token.should == nil
  end

  it "should has no api token set yet - testing thru alias" do
    Scalarium.configure.api_token.should == nil
  end

  it "we should be able to set api token and check it's presence" do
    Scalarium.configuration.api_token = "FAKE_TOKEN"
    Scalarium.configuration.api_token.should == "FAKE_TOKEN"
  end
  
  it "by using alias we should be able to obtain details set thru 'configuration' check it's presence change it and check again" do
    Scalarium.configure.api_token.should == "FAKE_TOKEN"
    Scalarium.configure.api_token = "FAKE_TOKEN_NEW"    
    Scalarium.configure.api_token.should == "FAKE_TOKEN_NEW"    
  end
  
end