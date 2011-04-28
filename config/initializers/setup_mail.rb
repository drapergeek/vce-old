ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "drapergeek.com",
  :user_name            => "4hcamp@drapergeek.com",
  :password             => "4hcampemailVT",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
