module Scalarium
  
  class API < AbstractAPI
    # Method fetches all clouds on the server    
    #
    # @option [String]       - cloud id of the cloud we want to see or nothing then we get the list of all clouds
    #
    # @return [Array]        - array containing all the clouds 
    # or when param is passed it gets the particular cloud and 
    # @return [Hash]         - @see API#get_cloud
    #
    def get_clouds(cloud_id=nil)
      return get_cloud(cloud_id) unless cloud_id.nil?
      http_get_request(Scalarium.clouds_url)      
    end
    
    # Method gets single could details 
    #
    # @param   [String]   cloud_id  - id of the cloud we want to see 
    # @return  [Hash]               - hash containing details for particular cloud
    # 
    def get_cloud(cloud_id)
      http_get_request(Scalarium.clouds_url+"/#{cloud_id}")      
    end
    
    def get_cloud_roles(cloud_id)
    end    
        
    # Method fetches all applications on the server
    # 
    # @return  [Array]              -     array containing all the applications 
    #
    def get_applications
      http_get_request(Scalarium.applications_url)
    end
    
    # Method pings scalarium to check the details of the deploy (i.e. progress)
    # @see http://support.scalarium.com/kb/api/fetching-deployment-details
    # 
    # @return [Hash]                -       Hash contains all the deployment details 
    # 
    def fetch_deployment_details(app_id, deployment_id)
      http_get_request(Scalarium.applications_url+"/#{app_id}/deployments/#{deployment_id}")
    end
    
    # Method allows to deploy application in scalarium
    #                                            
    # @param  [String]  app_id               -   The ID of application we want to deploy.
    #                                            
    # @option options [String]   :comment    -   comment to be displayed on the deployment
    # @option options [Boolean]  :migrate    -   boolean indicating if we should run the migrations too (false by default)
    #
    # @return [Hash] response of the progress and details
    # 
    def deploy_application(app_id, options = {:comment => nil, :migrate => false})
      json_command = JSON.dump(:command => 'deploy', 
                               :comment => options[:comment], 
                               :migrate => options[:migrate])
      http_post_request(Scalarium.applications_url+"/#{app_id}/deploy", json_command)                         
    end
  end
  
  # adding some better naming for the fetch_deployment_details -> get_deployment_details 
  # it is just an alias for existing method (so it stays backward compatible)
  API.class_eval{alias :get_deployment_details :fetch_deployment_details}
end