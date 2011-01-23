class WelcomeController < ApplicationController
  skip_before_filter :authorize

  def login
    respond_to do |format|
      format.html
    end
  end

end
