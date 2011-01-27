class JavascriptsController < ApplicationController
  
  if Rails.env == "production"
    before_filter :login_required
  else
    before_filter :set_dev_user
  end
  

  
  def hide_announcement
    session[:announcement_hide_time] = Time.now
  end
end
