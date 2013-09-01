require 'spec_helper'

describe Group do
  it "can create a group" do
    count = Group.count
    group = FactoryGirl.create(:group)
    Group.count.should be count + 1
  end
  it "can update a group" do
    group = FactoryGirl.create(:group)
    timestamp = group.updated_at
    group.description = "This is the new description"
    group.save
    group.reload
    group.description.should == "This is the new description"
    group.updated_at.should_not == timestamp
  end
  it "can destroy a group" do
    count = Group.count
    group = FactoryGirl.create(:group, :name => 'Delete Me')
    group.destroy
    Group.exists?(group.id).should be false
    Group.count.should be count
  end
  it "can find the owner of a group" do
    group = FactoryGirl.create(:group)
    user = FactoryGirl.create(:user)
    user.is_owner_of group
    expect(group.owner).to eq user
  end
end