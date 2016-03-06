require 'rails_helper'

feature 'Comments' do
  context 'creating comments' do
    scenario 'can comment on an existing post' do
      user = create :user
      post = create(:post, user_id: user.id)
      sign_in_with user
      visit '/'
      fill_in "comment_content_#{post.id}", with: 'Amazing'
      click_button 'Submit'
      expect(page).to have_content('Amazing')
    end
  end

  context 'deleting posts' do
    background do
    user = create :user
    user_two = create(:user, id: 2,
                             email: 'test@test.com',
                             user_name: 'carwyn')
    post = create :post
    comment = create(:comment, user_id: user_two.id,
                               post_id: post.id)
    comment_two = create(:comment, id: 2,
                                   post_id: post.id,
                                   content: 'Take me')
    sign_in_with user_two
  end
    scenario 'user can delete their own comments' do
      visit '/'
      expect(page).to have_content('Dog!')
      click_link 'delete-1'
      expect(page).to_not have_content('Dog!')
    end
    scenario 'user cannot delete a comment not belonging to them' do
      visit '/'
      expect(page).to have_content('Dog!')
      expect(page).to_not have_css('#delete-2')
    end
    scenario 'user cannot delete a comment not belonging to them' do
      visit '/'
      expect(page).to have_content('Dog!')
      page.driver.submit :delete, "posts/1/comments/2", {}
      expect(page).to have_content("That doesn't belong to you!")
      expect(page).to have_content('Dog!')
    end
  end

end
