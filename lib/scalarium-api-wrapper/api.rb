require 'rest-client'
require 'json'

module Scalarium
  
  class API
    
    # Method fetches all clouds on the server    
    #
    # @returns array [Array]       -    array containing all the clouds 
    #
    def get_clouds
      http_get_request(Scalarium.clouds_url)      
    end
    
    # Method fetches all applications on the server
    # 
    # @returns array  [Array]     -     array containing all the applications 
    #
    def get_applications
      http_get_request(Scalarium.applications_url)
    end
    
    # Method pings scalarium to check the progress of the deploy
    # @see http://support.scalarium.com/kb/api/fetching-deployment-details
    # 
    # @returns hash [Hash]      -       Hash contains all the deployment details 
    # 
    def fetch_deployment_details(app_id, deployment_id)
      http_get_request(Scalarium.applications_url+"/api/applications/#{app_id}/deployments/#{deployment_id}")
    end
    
    # Method allows to deploy application in scalarium
    #
    # @option app_id    [String]  -     The ID of application we want to deploy.
    #
    # @option options   [Hash]    -     Hash with options:
    #   :comment                  -     comment to be displayed on the deployment
    #   :migrate                  -     boolean indicating if we should run the migrations too (false by default)
    #
    # @returns [Hash] response of the progress and details
    # 
    def deploy_application(app_id, options = {:comment => nil, :migrate => false})
      json_command = JSON.dump(:command => 'deploy', 
                               :comment => options[:comment], 
                               :migrate => options[:migrate])
      http_post_request(Scalarium.applications_url+"/#{app_id}/deploy", json_command)                         
    end
    
    
    private
    def get_headers
      # quick validation if the header is set
      if Scalarium.headers['X-Scalarium-Token'].nil? || Scalarium.headers['X-Scalarium-Token'] == "" 
        raise ArgumentError "X-Scalarium-Token is not set"
      end
      Scalarium.headers     
    end
    
    # Method uses RestClient to make a HTTP POST request to Scalarium API    
    def http_post_request(url, json_command)
      JSON.parse(RestClient.post(url, json_command, get_headers))
    end

    # Method uses RestClient to make a HTTP GET request to Scalarium API    
    def http_get_request(url)
      JSON.parse(RestClient.get(url, get_headers))
    end
    
    
  end
end