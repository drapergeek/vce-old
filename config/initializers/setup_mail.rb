Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
if Rails.env.development?
 ActionMailer::Base.default_url_options[:host] = "localhost:3000"
else
 ActionMailer::Base.default_url_options[:host] = "vce.heroku.com"
end
