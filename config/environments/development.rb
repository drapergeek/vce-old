
# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Enable the breakpoint server that script/breakpointer connects to
#config.breakpoint_server = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false

config.action_view.debug_rjs                         = true

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = true

#config.action_mailer.delivery_method = :smtp
#config.action_mailer.smtp_settings = {
#:address => "auth.smtp.vt.edu",
#:port => 465,
#:authentication => :login,
#:domain=>"vt.edu",
#:user_name => "gdraper",
#:password => "mjisseXee2me@vt",
#:tls=>true
#}
#config.action_mailer.smtp_settings = {
#    :enable_starttls_auto => true,
#    :address => "smtp.gmail.com",
#    :port => "587",
#    :domain => "google.com",
#    :authentication => :plain,
#    :user_name => "drapersjunk",
#    :password => "lx8143xpmac"
#}
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'gmail.com',
  :authentication => :plain,
  :user_name => '4hprogrammer',
  :password => 'simple4hpassword'
}