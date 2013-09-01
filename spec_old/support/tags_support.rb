shared_context "tags support" do
  before :each do
    @group = FactoryGirl.create(:group, :tag_list => 'foo, bar')
    @page = FactoryGirl.create(:page, :tag_list => 'foo, bar')
    @person = FactoryGirl.create(:user, :skill_list => 'foo, bar', :hobby_list => 'fan, do', :interest_list => 'back, to')
    @foo = Tag.find_by_name('foo')
  end
end
