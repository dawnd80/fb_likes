class FriendsController < ApplicationController
  before_filter :ensure_facebook_gapi

  def index
    @user = @graph.get_object('me')
    @friends = @graph.get_connections(@user['id'], "friends")
    respond_to do |format|
      format.html
    end
  end
  
  protected
  def ensure_facebook_gapi
    @graph = Koala::Facebook::GraphAPI.new(access_cookies)
  end
end