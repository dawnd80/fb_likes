class FriendsController < ApplicationController
  before_filter :ensure_facebook_gapi
  before_filter :ensure_user_object

  def index
    @friends = @graph.get_connections(@user['id'], "friends").sort{|f1, f2| f1['name'] <=> f2['name']}
    respond_to do |format|
      format.html
    end
  end

  def show_likes
    user_likes = @graph.get_connections(@user['id'], "likes")
    friend_likes = @graph.get_connections(params[:friend_id], "likes")
    common_likes_ids = user_likes.map{|like| like['id'].to_i} & friend_likes.map{|like| like['id'].to_i}
    @friend = @graph.get_object(params[:friend_id])
    @commons = user_likes.select{|u| common_likes_ids.include?(u['id'].to_i)}
    respond_to do |format|
      format.html
    end
  end

  protected
  def ensure_facebook_gapi
    @graph = Koala::Facebook::GraphAPI.new(access_cookies)
  end
  
  def ensure_user_object
    @user = @graph.get_object('me')
  end
end