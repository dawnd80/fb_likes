# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  #filter_parameter_logging :password
  
  before_filter :parse_facebook_cookies
  
  def access_cookies
    return @access_cookies if defined?(@access_cookies)
    return nil if @facebook_cookies.nil?
    @access_token = @facebook_cookies['access_token']
  end

  protected
  
  def parse_facebook_cookies
    @facebook_cookies ||= Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
  end
  
end
