class JavascriptsController < ApplicationController
    before_filter :login_required
  def hide_announcement
    session[:announcement_hide_time] = Time.now
  end
end
