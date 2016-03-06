require 'rails_helper.rb'

feature 'posts' do

  context 'creating posts' do

    scenario 'should display a prompt to add an image' do
      visit '/'
      click_link 'New Post'
      fill_in 'Caption', with: 'lala'
      click_button 'Create Post'
      expect(page).to have_content('Pic needed to create post')
    end

    scenario 'user can create a post when user clicks create post' do
      visit '/'
      click_link 'New Post'
      attach_file('Image', "spec/files/images/surfsup.jpg")
      fill_in 'Caption', with: "france #surfing time"
      click_button 'Create Post'
      expect(page).to have_content("#surfing time")
      expect(page).to have_css("img[src*='surfsup.jpg']")
    end

  end

  context 'deleting posts' do
    before {Post.create caption: 'Tube'}

    scenario 'user can delete a post when user clicks delete post' do
      visit '/'
      click_link 'Edit Post'
      click_link 'Delete Post'
      expect(page).not_to have_content 'Tube'
      expect(page).to have_content 'Post successfully deleted'
    end

  end

  # context 'editing posts' do
  #   scenario 'a user can edit a post when user clicks eid
  # end
end