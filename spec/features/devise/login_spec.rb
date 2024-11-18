RSpec.feature 'User Login', type: :feature do
  let!(:user) { User.create(email: 'test@example.com', password: 'password123') }

  scenario 'User successfully logs in' do
    visit new_user_session_path

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password123'

    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_current_path(root_path)
  end

  scenario 'User enters invalid credentials' do
    visit new_user_session_path
  
    fill_in 'Email', with: 'wrong@example.com'
    fill_in 'Password', with: 'wrongpassword'
  
    click_button 'Log in'
  
    expect(page).to have_content('Invalid Email or password.')
  end
end