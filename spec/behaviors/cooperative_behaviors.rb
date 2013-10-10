module CapybaraNodeExtensions
  def navbar(containing)
    find('.navbar', :text => containing)
  end
end

shared_examples 'a cooperative page' do |title|
  subject { page }

  ## disabled for now
  #describe 'having valid HTML5' do
  #  its(:html) { should_not be_empty }
  #  its(:html) { should be_valid_html }
  #end

  describe 'optimized for search engines' do
    it { should have_xpath '//title', :visible => false, :text => /^#{title}: #{Cooperative.configuration.application_name}/ }
    it { should have_xpath '//meta[@name=\'keywords\']', :visible => false }
    it { should have_xpath '//meta[@name=\'description\']', :visible => false }
    it { should have_selector 'h1', :text => title }
  end

  describe 'having the required stylesheets' do
    it { should have_xpath '//link[starts-with(@href, \'/assets/cooperative.css\')]', :visible => false }
    it { should have_xpath '//link[starts-with(@href, \'/assets/application.css\')]', :visible => false }
  end

  describe 'having the required javascripts', :js => true do # at least the major ones
    it { should have_xpath '//script[starts-with(@src, \'/assets/cooperative.js\')]', :visible => false }
    it { should have_xpath '//script[starts-with(@src, \'/assets/application.js\')]', :visible => false }
  end

  describe 'having a bootstrap layout' do
    describe 'containing a navbar' do
      subject { page.navbar Cooperative.configuration.application_name }
      it { should have_selector "a.brand[href='#{cooperative.home_path}']", :text => Cooperative.configuration.application_name }
      it { should have_link :people.l, :href => cooperative.people_path }
      it { should have_link :groups.l, :href => cooperative.groups_path }
      it { should have_link :tags.l, :href => cooperative.tags_path }
      it 'may have a badge, and if it does, it should be a messages link with a number' do
        navbar = page.navbar(Cooperative.configuration.application_name)
        if navbar.has_selector? '.badge'
          expect(navbar).to have_selector "a[href='#{cooperative.messages_path}']", :text => /0-9+/
        end
      end
      it 'should have either a sign in link or a user dropdown menu' do
        navbar = page.navbar(Cooperative.configuration.application_name)
        unless navbar.has_link? :sign_in.l, :href => new_user_session_path
          expect(navbar).to have_selector "a[href='#{cooperative.profile_path}']", :text => /^Logged in as.*/
        end
      end
    end
    it { should have_selector '.container', :minimum => 1 }
  end
end

shared_examples 'an opengraph node' do
  describe 'providing opengraph data' do
    it { should have_xpath '//meta[@name=\'og:title\']', :visible => false }
    it { should have_xpath '//meta[@name=\'og:image_url\']', :visible => false }
  end
end

shared_examples 'a page with an infinite scroll area' do

  context 'before scrolling' do
    subject { page
      page.save_screenshot('scroll.png')
    }
    it { should have_selector '.infinitescroll', :count => 1 }
    it { should have_selector '.infinitescroll-item', :count => 25 }
    it { should have_selector 'nav.pagination a[rel=next]' }
  end

  context 'after scrolling', :js => true do
    before do
      page.execute_script 'window.scrollBy(0,1000000000)'
    end
    subject { page }
    it { should have_selector '.infinitescroll-item', :minimum => 26 }
  end

end

shared_examples 'a page with a pager' do

  describe 'pagination' do
    subject { page }
    it { should have_selector 'nav.pagination' }
  end

end

shared_examples 'a page with an object error' do |class_name|
  describe 'object error' do
    subject { page }
    it { should have_selector '.alert-error', :text => "There were errors that prevented this #{class_name} from being saved" }
  end
end

shared_examples 'a page with an object creation message' do |class_name|
  describe 'object creation message' do
    subject { page }
    it { should have_selector '.alert-info', :text => "#{class_name} was successfully created." }
  end
end

shared_examples 'a page with an object update message' do |class_name|
  describe 'object update message' do
    subject { page }
    it { should have_selector '.alert-info', :text => "#{class_name} was successfully updated." }
  end
end