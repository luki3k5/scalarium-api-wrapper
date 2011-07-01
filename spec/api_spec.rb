require 'spec_helper'

describe "Scalarium::API", "when first created" do

  before(:all) do
    Scalarium.configuration.api_token = "FAKE_TOKEN"
    @api = Scalarium::API.new
    @clouds_url = "https://manage.scalarium.com/api/clouds"
    @applications_url = "https://manage.scalarium.com/api/applications"
  end
  
  # notice that get_headers is private method so we test it thru send
  it "should have api token in headers set" do
    @api.send(:get_headers)['X-Scalarium-Token'].should == "FAKE_TOKEN"
  end

  # notice that get_headers is private method so we test it thru send  
  it "should have Accept piece of header set automatically " do 
    @api.send(:get_headers)['Accept'].should == "application/vnd.scalarium-v1+json"    
  end
  
  it "Scalarium Module should return correct applications url" do
    Scalarium.applications_url.should == @applications_url
  end

  it "Scalarium Module should return correct clouds url" do
    Scalarium.clouds_url.should == @clouds_url
  end
  
  it "should be able to deploy application" do
    @api.should respond_to(:deploy_application)
  end

  it "should be able to get all the clouds" do
    @api.should respond_to(:get_clouds)
  end
  
  it "should be able to get single cloud" do
    @api.should respond_to(:get_cloud)
  end
  
  it "should be able to get list cloud's roles" do
    @api.should respond_to(:get_cloud_roles)
  end

  it "should be able to get list cloud's instances"
    #@api.should respond_to(:get_cloud_instances)

  it "should be able to get cloud's instances of a specific role"

  it "should be able to get cloud's single instance"



  it "should be able to get all the applications" do
    @api.should respond_to(:get_applications)
  end

  it "should be able to get deployment status aka deployment details" do
    @api.should respond_to(:fetch_deployment_details)
  end
  
  it "should be able to get deployment status aka deployment details with alias" do
    @api.should respond_to(:get_deployment_details)
  end

  
end