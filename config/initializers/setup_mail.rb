if Rails.env.development?
  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "drapergeek.com",
    :user_name            => "jason@drapergeek.com",
    :password             => "mjisseXee2me",
    :authentication       => "plain",
    :enable_starttls_auto => true
  }

  ActionMailer::Base.default_url_options[:host] = "localhost:3000"
  Mail.register_interceptor(DevelopmentMailInterceptor)
else
  ActionMailer::Base.smtp_settings = {
    :port           => ENV['MAILGUN_SMTP_PORT'], 
    :address        => ENV['MAILGUN_SMTP_SERVER'],
    :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
    :password       => ENV['MAILGUN_SMTP_PASSWORD'],
    :domain         => 'vce.heroku.com',
    :authentication => :plain,
  }
  ActionMailer::Base.delivery_method = :smtp
end
