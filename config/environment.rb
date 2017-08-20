# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :address => 'smtp.sendgrid.net',
  :port => '587',
  :authentication => :plain,
  :user_name => ENV['SANDGRID_USERNAME'],
  :password => ENV['SANDGRID_PASSWORD'],
  :domain => 'herokuc.com',
  :enable_starttls_auto => true
}
