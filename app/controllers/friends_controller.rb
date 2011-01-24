class FriendsController < ApplicationController
  before_filter :ensure_user_object

  def index
    @friends = @user.friends
    respond_to do |format|
      format.html
    end
  end

  def show_likes
    user_likes = @user.likes
    @friend = @user.friend(params[:friend_id])
    friend_likes = @user.friend_likes(params[:friend_id])
    common_likes_ids = user_likes.map{|like| like['id'].to_i} & friend_likes.map{|like| like['id'].to_i}
    @commons = user_likes.select{|like| common_likes_ids.include?(like['id'].to_i)}
    respond_to do |format|
      format.html
    end
  end

  protected
  def ensure_user_object
    @user = FBUser.new(access_cookies)
  end
end