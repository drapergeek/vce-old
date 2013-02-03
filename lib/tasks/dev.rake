namespace :dev do
  desc "Creates some sample data for testing locally"
  task prime: 'db:seed' do
    require 'database_cleaner'
    require 'factory_girl_rails'

    include FactoryGirl::Syntax::Methods

    if Rails.env != "development"
      raise "This task can only be create in the development environment"
    end

    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean

    puts "Creating development data..."
    user = create(:user, email: 'admin@example.com')
    puts "User login: #{user.email} / #{user.password}"

    admin_role = Role.find_or_create_by_name("admin")
    user.roles << admin_role
    user.save
  end
end
