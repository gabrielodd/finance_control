require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL, type: :feature

  config.before(:each, type: :feature) do
    Capybara.reset_sessions!
  end
end

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome