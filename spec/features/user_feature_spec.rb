require 'rails_helper'

feature 'user' do

  context 'creating a new user' do
    background do
      visit '/'
      click_link 'Register'
    end
    scenario 'can create a new user via the index page' do
      fill_in 'User name', with: 'sarahla'
      fill_in 'Email', with: 'test@test.com'
      fill_in 'Password', with: 'supersecret123', match: :first
      fill_in 'Password confirmation', with: 'supersecret123'
      click_button 'Sign up'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end

    scenario 'requires a user name to successfully create an account' do
      fill_in 'Email', with: 'sxyrailsdev@myspace.com'
      fill_in 'Password', with: 'supersecret', match: :first
      fill_in 'Password confirmation', with: 'supersecret'
      click_button 'Sign up'
      expect(page).to have_content("can't be blank")
    end

    scenario 'requires a user name to be more than 3 characters' do
      fill_in 'User name', with: 'so'
      fill_in 'Email', with: 'sarah@dotenv'
      fill_in 'Password', with: 'supersecretlala', match: :first
      fill_in 'Password confirmation', with: 'supersecretlala'
      click_button 'Sign up'
      expect(page).to have_content('minimum is 3 characters')
    end

    scenario 'requires a user name to be less than 12 characters' do
      fill_in 'User name', with: 's' * 13
      fill_in 'Email', with: 'sarah@sarah.com'
      fill_in 'Password', with: 'supersecret123', match: :first
      fill_in 'Password confirmation', with: 'supersecret123'
      click_button 'Sign up'
      expect(page).to have_content("maximum is 12 characters")
    end
  end

end
