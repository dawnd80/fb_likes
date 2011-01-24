require 'rubygems'
require 'httpclient'
require 'json'

class FBTestUser

  def initialize(argv)
    @user_id = argv[1]
    @friend_id = argv[2]
  end
  
  def get_access_token
    response = nil
    clnt = HTTPClient.new
    args = {'grant_type'=>'client_credentials', 'client_id' => 185076204847204, 'client_secret' => '68993ed8733798585746e37afe9c3563'}
    response = clnt.get("https://graph.facebook.com/oauth/access_token", args)
    response.content.split('=')[1]
  end

  def add_new_user
    clnt = HTTPClient.new
    token = get_access_token
    post_args = "installed=true&permissions=read_stream&access_token=#{token}"
    response = clnt.post("https://graph.facebook.com/185076204847204/accounts/test-users", post_args)
    puts "#{response.content}"
  end
  
  def add_friend
    clnt = HTTPClient.new
    
    #friend request
    user_token = "access_token=" + get_token(clnt, @user_id)
    response = clnt.post("https://graph.facebook.com/#{@user_id}/friends/#{@friend_id}", user_token)
    puts "#{response.content}"
    
    #confirm request
    friend_token = "access_token=" + get_token(clnt, @friend_id)
    response = clnt.post("https://graph.facebook.com/#{@friend_id}/friends/#{@user_id}", friend_token)
    puts "#{response.content}"
  end
  
  def get_token(clnt, userid)
    args = "access_token=#{get_access_token}"
    response = clnt.get("https://graph.facebook.com/185076204847204/accounts/test-users", args)
    data = JSON.parse(response.content)
    users = data["data"]
    data["data"].each do |v|
      if v["id"].eql?(userid.to_s)
        return v["access_token"]
      end
    end
    nil
  end
  
  def delete_users
    clnt = HTTPClient.new
    args = "access_token=#{get_access_token}"
    response = clnt.get("https://graph.facebook.com/185076204847204/accounts/test-users", args)
    data = JSON.parse(response.content)
    puts "#{data["data"].inspect}"
    data["data"].each do |v|
      args = "access_token=" + v["access_token"]
      res = clnt.request("delete", "https://graph.facebook.com/"+v["id"], args)
      puts "deleted #{res.content}"
    end
  end
end

if ARGV[0] and ARGV[0].eql?('add_user')
  FBTestUser.new(ARGV).add_new_user
elsif ARGV[0] and ARGV[0].eql?('add_friend')
  FBTestUser.new(ARGV).add_friend
elsif ARGV[0] and ARGV[0].eql?('delete')
  FBTestUser.new(ARGV).delete_users
end


#user1
#{"id":"100002059062137","access_token":"185076204847204|2.8daR99iVjS9dEBz7PV7EQA__.3600.1295870400-100002059062137|z8TRyS-xJr7K03Tfi1EADM2lTuI","login_url":"https:\/\/www.facebook.com\/platform\/test_account_login.php?user_id=100002059062137&n=g92ijpqv2S2mfk2"}

#user2
#{"id":"100001940480966","access_token":"185076204847204|2.oQxm70Q7zL3xujriQWeSYg__.3600.1295870400-100001940480966|TDw1YYS0-b3q4gYzgJOZFcQWWzI","login_url":"https:\/\/www.facebook.com\/platform\/test_account_login.php?user_id=100001940480966&n=o387PROblS04H4R"}

#user3
#{"id":"100002014661857","access_token":"185076204847204|2.k5dTm1IP4BvTaHE87ylthw__.3600.1295870400-100002014661857|u-38Wkz8d2vz5ZZziuvifouoe18","login_url":"https:\/\/www.facebook.com\/platform\/test_account_login.php?user_id=100002014661857&n=He3gS42Xnr0om68"}
