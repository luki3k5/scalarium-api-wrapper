module Scalarium
  
  def self.clouds_url
    Scalarium.configuration.clouds_url
  end

  def self.applications_url
    Scalarium.configuration.applications_url
  end
  
  def self.headers
    return {'X-Scalarium-Token' => "#{Scalarium.configuration.api_token}", 'Accept' => 'application/vnd.scalarium-v1+json' }
  end
  
  # @return [Configuration] The configuration singleton.
  def self.configuration
    @configuration ||= Scalarium::Configuration.new
  end
end


require "scalarium-api-wrapper/version"
require "scalarium-api-wrapper/configuration"
require "scalarium-api-wrapper/api"