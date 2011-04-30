ActionMailer::Base.smtp_settings = {
  :address              => "auth.smtp.vt.edu",
  :port                 => 587,
  :domain               => "vt.edu",
  :user_name            => "gdraper",
  :password             => "c0dM@Cd@em0n1925",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
