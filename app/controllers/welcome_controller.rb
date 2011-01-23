class WelcomeController < ApplicationController
  before_filter :ensure_facebook_gapi

  def new
    if access_cookies
      @friends = @graph.get_connections("me", "friends")
      @user = @graph.get_object("me")
    end
    respond_to do |format|
      format.html
    end
  end
  
  protected
  def ensure_facebook_gapi
    @graph = Koala::Facebook::GraphAPI.new
  end
end
