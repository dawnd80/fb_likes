require 'erb'
require 'yaml'
require 'httpclient'

module DataParser
  extend self

  file_path = File.join(File.dirname(__FILE__), 'fixtures/fb_users.yml') 
  RESPONSES = YAML.load(ERB.new(IO.read(file_path)).result(binding))

  def get_data(name)
    response = RESPONSES[name]
    RESPONSES[name]["access_token"] = get_access_token(response["id"])
    RESPONSES[name]
  end
  
  def get_access_token(userid)
    clnt = HTTPClient.new
    args = "access_token=#{get_app_token}"
    response = clnt.get("https://graph.facebook.com/185076204847204/accounts/test-users", args)
    data = JSON.parse(response.content)
    data["data"].each do |v|
      return v["access_token"] if v["id"].eql?(userid.to_s)
    end
    return nil
  end
  
  def get_app_token
    return @token if defined?(@token)
    clnt = HTTPClient.new
    args = {'grant_type'=>'client_credentials', 'client_id' => 185076204847204, 'client_secret' => '68993ed8733798585746e37afe9c3563'}
    response = clnt.get("https://graph.facebook.com/oauth/access_token", args)
    @token = response.content.split('=')[1]
  end
end
