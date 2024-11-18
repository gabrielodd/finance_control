require 'rails_helper'

RSpec.describe "Index page", type: :feature do
  context "User is not logged in" do
    scenario "User visits the homepage" do
      visit root_path

      expect(page).to have_content("Log in")
    end
  end

  context "User is logged in" do
    let!(:user) { User.create(email: 'test@example.com', password: 'password123') }

    scenario "User without expenses visits the homepage" do
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password123'
      click_button 'Log in'

      expect(page).to have_content("You don't have any expenses!")
    end
  end
end