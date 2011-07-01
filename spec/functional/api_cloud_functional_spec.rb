require 'spec_helper'
require 'yaml'


describe "Scalarium api", "obtaining clouds and then single cloud details" do
  
  before(:all) do
    # we load configuration 
    config = YAML::load(File.open("./scalarium.yml"))
    raise "!!! scalarium.yml file is missing - have your renamed scalarium.yml.sample into scalarium.yml? !!!" if config.nil?

    @cloud_keys = %w( id name region nickname_theme custom_agent_version default_os deleted_at created_at updated_at custom_json use_custom_cookbooks scm_user scm_password scm_type scm_url scm_ssh_key scm_revision account_id user_id ssh_key_id credential_id )    
    
    Scalarium.configuration.api_token = config["api_token"]    
    @api = Scalarium::API.new
  end
  
  it "be able to obtain list of clouds and then get the details of first cloud from the list" do
    # we should get at least one cloud 
    @api.get_clouds.first['id'].nil?.should == false 
    single_cloud = @api.get_cloud(@api.get_clouds.first['id'])

    # checking if we received planed Hash structure
    single_cloud.keys.each do |key|  
      @cloud_keys.include?(key).should == true
    end
  end
  
  
end