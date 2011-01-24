class FriendsController < ApplicationController
  before_filter :ensure_user_object

  def index
    @friends = @user.friends
    respond_to do |format|
      format.html
    end
  end

  def show_likes
    if params[:friend_id].nil?
      error = true
    else
      @friend = @user.friend(params[:friend_id])
      @commons = @user.find_commons(params[:friend_id])
    end
    respond_to do |format|
      if error
        flash[:error] = "Please select a friend"
        format.html { redirect_to friends_url }
      else
        format.html
      end
    end
  end

  protected
  def ensure_user_object
    @user = FbUser.new(access_cookies)
  end
end