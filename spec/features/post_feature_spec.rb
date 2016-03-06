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
      # attach_file 'post[image]', Rails.root.join('spec','files', 'images','surfsup.jpg')
      attach_file('Image', "spec/files/images/surfsup.jpg")
      fill_in 'Caption', with: "france #surfing time"
      click_button 'Create Post'
      expect(page).to have_content("#surfing time")
      expect(page).to have_css("img[src*='surfsup.jpg']")
    end

    it "won't update a post without an image" do
      attach_file('Image', 'spec/files/dummy.zip')
      click_button 'Update Post'
      expect(page).to have_content("Wrong format")
    end

  end

  context 'displaying posts' do

    scenario 'the index displays correct created job information' do
      job_one = create(:post, caption: "This is post one")
      job_two = create(:post, caption: "This is the second post")
      visit '/'
      expect(page).to have_content("This is post one")
      expect(page).to have_content("This is the second post")
      expect(page).to have_css("img[src*='surfsup']")
    end

  end

    context'Editing posts' do
      background do
        job = create(:post)
        visit '/'
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
        post = create(:post, caption: 'gogo')
        visit '/'
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
