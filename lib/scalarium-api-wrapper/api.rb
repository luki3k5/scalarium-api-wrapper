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
    
    # Method obtains roles per cloud
    #
    # @param  [String]   cloud_id  - id of the cloud of which roles we want to see 
    # @return [Array]              - list of the roles 
    #
    def get_cloud_roles(cloud_id)
      http_get_request(Scalarium.clouds_url+"/#{cloud_id}/roles")      
    end

    # Method obtains details of all instances for a given role
    #
    # @param [String] cloud_id     - id of the cloud instance detail we want to obtain
    # @param [String] role_id      - id of the role for specified cloud we want instances for
    # @return [Hash]               - hash with details about the passed instance of the cloud
    #
    def get_role_instances(cloud_id, role_id)
      http_get_request(Scalarium.clouds_url+"/#{cloud_id}/roles/#{role_id}/instances")
    end
    
    # Method obtains instances of the cloud
    #
    # @param  [String]   cloud_id  - id of the cloud of which instances we want to see 
    # @return [Array]              - list of the instances
    #
    def get_cloud_instances(cloud_id)
      http_get_request(Scalarium.clouds_url+"/#{cloud_id}/instances")      
    end
    
    # Method obtains details of specified instance for a given cloud
    #
    # @param [String] cloud_id     - id of the cloud instance detail we want to obtain
    # @param [String] instance_id  - id of the instance for specified cloud we want to see
    # @return [Hash]               - hash with details about the passed instance of the cloud
    #
    def get_instance_of_cloud(cloud_id, instance_of_cloud_id)
      http_get_request(Scalarium.clouds_url+"/#{cloud_id}/instances/#{instance_of_cloud_id}")      
    end
    
    # Method allows to send command to the instance of specified cloud
    #
    # @param [String] cloud_id
    # @param [String] instance_id
    # @param [Symbol] command - it can be one of :start, :stop, :reboot
    #
    def send_instance_command(cloud_id, instance_id, command)
      commands = [:start, :reboot, :stop]
      raise ArgumentError, "You have passed wrong command allowed ones are: #{commands}" if !commands.include?(command) 

      http_post_request(Scalarium.clouds_url+"/#{cloud_id}/instances/#{instance_id}/#{command.to_s}")  
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
    # @param  [String] app_id        -       String app_id of application we want to see
    # @param  [String] deployment_id -       String id of the deployment we want to see
    # @return [Hash]                 -       Hash contains all the deployment details 
    # 
    def fetch_deployment_details(app_id, deployment_id)
      http_get_request(Scalarium.applications_url+"/#{app_id}/deployments/#{deployment_id}")
    end
    
    # @see http://support.scalarium.com/discussions/questions/83-is-it-possible-to-obtain-all-the-deployments-for-the-specified-application
    # Method allows to fetch all the deployments for the specified application
    # 
    # @param  [String] app_id         -       String app_id of application that deployments we want to see  
    # @return [Array]                 -       Delivers array of all the deployments for the application
    def fetch_all_deployments(app_id)
      warn "[WARRNING!] This functionality might not be yet supported by Scalarium!"
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
end

# ALIASES:
#
# adding some better naming for the fetch_deployment_details -> get_deployment_details 
# it is just an alias for existing method (so it stays backward compatible)
Scalarium::API.class_eval do
  alias :get_deployment_details :fetch_deployment_details   
  alias :get_all_deployments :fetch_all_deployments
end
