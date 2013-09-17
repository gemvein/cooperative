shared_examples 'a cooperative page' do |title|
  subject { page }

  describe 'having valid HTML5' do
    its(:html) { should_not be_empty }
    its(:html) { should be_valid_html }
  end

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
    it { should have_selector '.navbar', :count => 1 }
    it { should have_selector '.container', :minimum => 1 }
  end

  describe 'showing the configured application name' do
    it { should have_selector '.brand', :text => Cooperative.configuration.application_name }
  end
end

shared_examples 'a page with an infinite scroll area' do

  context 'before scrolling' do
    subject { page }
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