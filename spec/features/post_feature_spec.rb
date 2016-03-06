require 'rails_helper.rb'

feature 'posts' do
  background do
    user = create :user
    visit '/'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

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
      # attach_file 'post[image]', Rails.root.join('spec','files', 'images','surfsup.jpg')
      attach_file('Image', "spec/files/images/surfsup.jpg")
      fill_in 'Caption', with: "france #surfing time"
      click_button 'Create Post'
      expect(page).to have_content("#surfing time")
      expect(page).to have_css("img[src*='surfsup.jpg']")
    end
    scenario 'cannot post without an image' do
      visit '/'
      click_link "New Post"
      fill_in 'Caption', with: "GO!"
      click_button 'Create Post'
      expect(page).to have_content("Need an image")
    end
    scenario 'image in post needs to be in right format' do
      visit '/'
      click_link "New Post"
      attach_file('Image', 'spec/files/dummy.zip')
      fill_in 'Caption', with: "GO!"
      click_button 'Create Post'
      click_button 'Create Post'
      expect(page).to have_content("Wrong format")
    end
  end

  context 'displaying posts' do
    background do
      post_one = create(:post, caption: "This is post one")
      post_two = create(:post, caption: "This is the second post")
      user = create :user

      visit '/'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end
    scenario 'the index lists all posts' do
      expect(page).to have_content("This is post one")
      expect(page).to have_content("This is the second post")
      expect(page).to have_css("img[src*='surfsup']")
    end
  end

  context'Editing posts' do
    background do
      user = create :user
      post = create(:post, user_id: user.id)
      visit '/'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      find(:xpath, "//a[contains(@href,'posts/1')]").click
      click_link 'Edit Post'
    end
    scenario 'Can edit a post' do
      fill_in 'Caption', with: "lalala!"
      click_button 'Update Post'
      expect(page).to have_content("Post updated")
      expect(page).to have_content("lalala!")
    end
  end

    context 'Deleting posts' do
      background do
        user = create :user
        post = create(:post, user_id: user.id)
        visit '/'
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
        find(:xpath, "//a[contains(@href,'posts/1')]").click
        click_link 'Edit Post'
      end
      scenario 'Can delete a single post' do
        click_link 'Delete Post'
        expect(page).to have_content('Post deleted')
        expect(page).to_not have_content('gogo')
      end
    end

  end
