CopycopterClient.configure do |config|
  config.api_key = ENV['COPYCOPTER_KEY']
  config.host = 'geekcopter.herokuapp.com'
end
