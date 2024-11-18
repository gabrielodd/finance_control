require 'rails_helper'

RSpec.feature 'User Registration', type: :feature do
  scenario 'User successfully signs up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_current_path(root_path)
  end

  scenario 'User enters mismatched passwords' do
    visit new_user_registration_path
  
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password456'
  
    click_button 'Sign up'
  
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end