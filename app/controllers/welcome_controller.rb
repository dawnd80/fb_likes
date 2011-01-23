class WelcomeController < ApplicationController
  def new
    @graph = Koala::Facebook::GraphAPI.new
    @user = @graph.get_object("me")
    respond_to do |format|
      format.html
    end
  end
end
