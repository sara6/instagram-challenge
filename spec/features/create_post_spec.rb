require 'rails_helper.rb'

feature 'Creating posts' do
  scenario 'can create a job' do
    visit '/'
    click_link 'New Post'
    attach_file('Image', "spec/files/images/surf.jpg")
    fill_in 'Caption', with: 'surfs up'
    click_button 'Create Post'
    expect(page).to have_content('surfs up')
    expect(page).to have_css("img[src*='surf.jpg']")
  end
end
