require 'rest-client'
require 'json'

module Scalarium
  
  class AbstractAPI
    
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