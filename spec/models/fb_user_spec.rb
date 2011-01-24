require 'spec_helper'
require 'data_parser'

describe FbUser do

  before(:each) do
    fake_user = DataParser.get_data('user')
    @user = FbUser.new(fake_user["access_token"])
  end

  it "should return user's friend" do
    @user.friends.select{|f| f['name'].include?('Mary')}.should be_true
    @user.friends.select{|f| f['name'].include?('Barbara')}.should be_true
  end
  
  it "should return the correct friend" do
    friend1 = DataParser.get_data('friend1')
    the_friend = @user.friend(friend1["id"])
    the_friend["name"].should == "Mary Amaidjdhjiff Baoberg"
  end
  
  it "should find commons if they both like a thing" do
    like1 = {"name"=>"Gizmodo","category"=>"Product/service","id"=>"5718758966"}
    like2 = {"name"=>"Happy Farm","category"=>"Application","id"=>"57132175859"}
    FbUser.stub!(:likes).with(@user.graph, @user.id).and_return([like1, like2])
    friend1 = DataParser.get_data('friend1')
    FbUser.stub!(:likes).with(@user.graph, friend1["id"]).and_return([like1])
    
    @user.find_commons(friend1["id"]).should include like1
    @user.find_commons(friend1["id"]).should_not include like2
  end
  
  it "should not find commons if they don't share a likes" do
    like1 = {"name"=>"Gizmodo","category"=>"Product/service","id"=>"5718758966"}
    FbUser.stub!(:likes).with(@user.graph, @user.id).and_return([like1])
    friend2 = DataParser.get_data('friend2')
    FbUser.stub!(:likes).with(@user.graph, friend2["id"]).and_return([])
    
    @user.find_commons(friend2["id"]).size.should == 0
  end
end
