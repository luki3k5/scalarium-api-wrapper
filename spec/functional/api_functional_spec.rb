require 'spec_helper'
require 'yaml'


describe "Scalarium functional tests", "when first created" do

  before(:all) do
    # we load configuration 
    config = YAML::load(File.open("./scalarium.yml"))
    raise "!!! scalarium.yml file is missing - have your renamed scalarium.yml.sample into scalarium.yml? !!!" if config.nil?
    
    Scalarium.configuration.api_token = config["api_token"]
    @application_id = config["app_id"]
    @comment = "This is test deploy by functional testing from scalarium-api-wrapper gem"
    
    @api = Scalarium::API.new
    
    # @response_status - this is initial response status 
    # returned after we make initial call to deploy application
    @response_status = nil
    # @status_check_response - this is status response for when we check 
    # progress of our deployment 
    @status_check_response = nil
  end
  
  it "should obtain list of applications and present an array" do
    @api.get_applications.class.should == Array
  end

  it "should obtain list of clouds and present an array" do
    @api.get_clouds.class.should == Array
  end
  
  it "should redeploy application with specified ID and comment: #{@comment} returning status should be in proper state" do
    @response_status = @api.deploy_application(@application_id, :comment => @comment)
    @response_status.class.should == Hash
    @response_status["status"].should == "running"
    @response_status["command"].should == "deploy" 
    @response_status["application_id"].should == @application_id

    sleep 2
    id_of_deployment = @response_status["id"]
    @status_check_response = @api.fetch_deployment_details(@application_id, id_of_deployment)
    @status_check_response.class.should == Hash
    @status_check_response["status"].should == "running"
  end
  
end