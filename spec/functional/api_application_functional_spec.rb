require 'spec_helper'
require 'yaml'


describe "Scalarium functional tests", "when first created" do

  before(:all) do
    # we load configuration 
    config = YAML::load(File.open(File.dirname(__FILE__)+"/scalarium.yml"))
    raise "!!! scalarium.yml file is missing - have your renamed scalarium.yml.sample into scalarium.yml? !!!" if config.nil?
    
    Scalarium.configuration.api_token = config["api_token"]
    @application_id = config["app_id"]
    @comment = "This is test deploy by functional testing from scalarium-api-wrapper gem"
    
    @api = Scalarium::API.new
  end
  
  it "should obtain list of applications and present an array" do
    @api.get_applications.class.should == Array
  end
  
  # it "should redeploy application with specified ID and comment: #{@comment} returning status should be in proper state" do
  #   @response_status = @api.deploy_application(@application_id, :comment => @comment)
  #   @response_status.class.should == Hash
  #   @response_status["status"].should == "running"
  #   @response_status["command"].should == "deploy" 
  #   @response_status["application_id"].should == @application_id
  # 
  #   sleep 2
  #   id_of_deployment = @response_status["id"]
  #   @status_check_response = @api.fetch_deployment_details(@application_id, id_of_deployment)
  #   @status_check_response.class.should == Hash
  #   @status_check_response["status"].should == "running"
  # end
  
end