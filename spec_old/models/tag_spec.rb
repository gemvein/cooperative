require 'spec_helper'

describe Tag do
  include_context "tags support"
  it "can add tags to a group" do
    expect(@group.tag_list).to include 'foo'
    expect(@group.tag_list).to include 'bar'
  end
  it "can add tags to a page" do
    expect(@page.tag_list).to include 'foo'
    expect(@page.tag_list).to include 'bar'
  end
  it "can add tags to a person" do
    expect(@person.skill_list).to include 'foo'
    expect(@person.skill_list).to include 'bar'
    expect(@person.hobby_list).to include 'fan'
    expect(@person.hobby_list).to include 'do'
    expect(@person.interest_list).to include 'back'
    expect(@person.interest_list).to include 'to'
  end
  it "can find users by tag" do
    expect(@foo.users_tagged_with).to include @person
  end
  it "can find groups by tag" do
    expect(@foo.groups_tagged_with).to include @group
  end
  it "can find pages by tag" do
    expect(@foo.pages_tagged_with).to include @page
  end
  it "can find total item counts" do
    counts = Tag.total_item_counts
    foo_hash = {:name => @foo.name, :count => 3}
    expect(counts).to include foo_hash
    expect(counts.count).to eq 6
  end
end