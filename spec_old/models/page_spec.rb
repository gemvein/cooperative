require 'spec_helper'

describe Page do
  it "can create a page" do
    count = Page.count
    page = FactoryGirl.create(:page)
    Page.count.should be count + 1
  end
  it "can update a page" do
    page = FactoryGirl.create(:page)
    timestamp = page.updated_at
    page.body = "<p>This is the new body</p>"
    page.save
    page.reload
    page.body.should == "<p>This is the new body</p>"
    page.updated_at.should_not == timestamp
  end
  describe "handles slugs appropriately" do
      it "won't save without a slug" do
        page = FactoryGirl.build(:page)
        page.slug = nil
        if page.save && !page.reload.slug
          fail "It shouldn't save without a slug"
        end
    end
    it "sets the slug on creation" do
      page = FactoryGirl.create(:page, :title => "This is the Page Title")
      page.slug.should == 'this-is-the-page-title'
    end
    it "does not update slug on page title change" do
      page = FactoryGirl.create(:page, :title => "This is the Slug")
      page.slug.should == 'this-is-the-slug'
      page.title = "This is the Page Title"
      page.save
      page.reload.slug.should == 'this-is-the-slug'
      page.reload.title.should == "This is the Page Title"
    end
  end
  it "can destroy a page" do
    count = Page.count
    page = FactoryGirl.create(:page, :title => 'Delete Me')
    page.destroy
    Page.exists?(page.id).should be false
    Page.count.should be count
  end
end
