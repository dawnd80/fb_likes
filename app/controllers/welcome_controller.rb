class WelcomeController < ApplicationController
  def login
    @access_token = facebook_cookies['access_token']
    respond_to do |format|
      format.html
    end
  end
end
