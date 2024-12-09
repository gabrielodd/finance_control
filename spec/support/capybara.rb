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

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: Selenium::WebDriver::Chrome::Options.new.tap do |options|
      options.add_argument('--disable-gpu')
      options.add_argument('--window-size=1920,1080')
    end
  )
end

# Capybara.javascript_driver = :selenium_chrome
Capybara.javascript_driver = :chrome