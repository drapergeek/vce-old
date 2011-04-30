ActionMailer::Base.smtp_settings = {
  :address              => "auth.smtp.vt.edu",
  :port                 => 587,
  :domain               => "vt.edu",
  :user_name            => "ddraper",
  :password             => "Kp1ig2D3$",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
