class WelcomeController < ApplicationController
  def new
    #@user = User.new
    respond_to do |format|
      format.html
    end
  end
end
