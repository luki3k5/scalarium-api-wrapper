class Scalarium::Configuration
  attr_accessor :api_token, :clouds_url, :applications_url

  def initialize
    @clouds_url = "https://manage.scalarium.com/api/clouds"
    @applications_url = "https://manage.scalarium.com/api/applications"
  end
end