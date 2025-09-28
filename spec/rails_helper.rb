require 'spec_helper'
require 'shoulda/matchers'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.before(:suite) do
    DatabaseCleaner.clean_with(:transaction)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :deletion
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include FactoryGirl::Syntax::Methods
  config.include LoginHelper
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
