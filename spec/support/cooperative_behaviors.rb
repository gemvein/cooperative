shared_examples 'a cooperative page' do |url|
  before do
    sign_in follower_user
    visit url
  end

  context 'is a valid HTML5 document' do
    subject { page.html }
    it { should_not be_empty }
    it { should be_valid_html }
  end

  context 'is optimized for search engines' do
    subject { page }
    it { should have_xpath 'title', :count => 1, :visible => false }
    it { should have_selector 'meta[name="keywords"]', :visible => false }
    it { should have_selector 'meta[name="description"]', :visible => false }
    it { should have_selector 'h1', :minimum => 1 }
  end

  context 'has the required stylesheets' do
    subject { page }
    it { should have_selector 'link[href^="/assets/cooperative.css"]', :visible => false }
    it { should have_selector 'link[href^="/assets/application.css"]', :visible => false }
  end

  context 'has the required javascripts at the end' do # at least the major ones
    subject { page }
    it { should have_selector 'footer script[src^="/assets/jquery.js"]', :count => 1, :visible => false }
    it { should have_selector 'footer script[src^="/assets/jquery_ujs.js"]', :count => 1, :visible => false }
    it { should have_selector 'footer script[src^="/assets/bootstrap.js"]', :count => 1, :visible => false }
    it { should have_selector 'footer script[src^="/assets/cooperative.js"]', :count => 1, :visible => false }
    it { should have_selector 'footer script[src^="/assets/application.js"]', :count => 1, :visible => false }
  end

  context 'looks like a bootstrap layout' do
    subject { page }
    it { should have_selector '.navbar', :count => 1 }
    it { should have_selector '.container', :minimum => 1 }
  end

  describe 'shows the configured application name' do
    subject { page }
    it { should have_selector '.brand', :text => Cooperative.configuration.application_name }
  end
end