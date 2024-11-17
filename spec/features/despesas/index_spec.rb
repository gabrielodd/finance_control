require 'rails_helper'

RSpec.describe "Index page", type: :feature do
  scenario "User visits the homepage" do
    visit root_path

    expect(page).to have_content("Log in")
  end
end