require 'rails_helper.rb'


feature 'posts' do

    scenario 'should display a prompt to add an image' do
      visit '/'
      click_link 'New Post'
      fill_in 'Caption', with: 'lala'
      click_button 'Create Post'
      expect(page).to have_content('Pic needed to create post')
    end

  scenario 'user can create a post' do
    visit '/'
    click_link 'New Post'
    attach_file('Image', "spec/files/images/surfsup.jpg")
    fill_in 'Caption', with: "france #surfing time"
    click_button 'Create Post'
    expect(page).to have_content("#surfing time")
    expect(page).to have_css("img[src*='surfsup.jpg']")
  end

end
