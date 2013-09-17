class ::Capybara::Session
  def statuses
    all('.status')
  end
end

shared_examples 'a page with a status form' do |selector, namespace|
  describe 'status form', :js => true do
    context 'with invalid attributes' do
      it 'alerts with an error message' do
        within selector do
          fill_in "#{namespace}_status_body", :with => ''
          click_button :set_status.l
        end
        expect(page).to have_content 'There were errors that prevented this status from being saved'
      end
    end
    context 'with valid attributes' do
      it 'posts the status via AJAX' do
        within selector do
          fill_in "#{namespace}_status_body", :with => 'I had a rooster and the rooster pleased me.'
          click_button :set_status.l
        end
        expect(page).to have_content 'I had a rooster and the rooster pleased me.'
      end
      describe 'tokenizing the body' do
        it 'handles #hashtags' do
          within selector do
            fill_in "#{namespace}_status_body", :with => 'This is a #hashtag.'
            click_button :set_status.l
          end
          expect(page).to have_selector 'a[href=\'/tags/hashtag\']', :text => '#hashtag', :count => 1
        end
        it 'handles @mentions' do
          within selector do
            fill_in "#{namespace}_status_body", :with => "This is a mention of @#{follower_user.nickname}."
            click_button :set_status.l
          end
          expect(page).to have_selector 'a[href=\'/people/' + follower_user.nickname + '\']', :text => "@#{follower_user.nickname}", :count => 1
        end
        it 'handles http:// links' do
          within selector do
            fill_in "#{namespace}_status_body", :with => 'This is a link to http://example.com/.'
            click_button :set_status.l
          end
          expect(page).to have_selector 'a[href=\'http://example.com/\']', :text => 'http://example.com/', :count => 1
        end
      end
      describe 'clears the old form fields' do
        it 'should clear the body' do
          within selector do
            fill_in "#{namespace}_status_body", :with => 'This is a test to be blanked out.'
            click_button :set_status.l
            sleep 30
          end
          expect(page.find("##{namespace}_status_body").value).to eq ''
        end
      end
    end
  end
end