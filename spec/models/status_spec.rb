require 'spec_helper'

describe Status do
  it "can create a status" do
    count = Status.count
    FactoryGirl.create(:status)
    Status.count.should be count + 1
  end
  it "can update a status" do
    status = FactoryGirl.create(:status)
    timestamp = status.updated_at
    status.body = "This is the new body"
    status.save
    status.reload
    status.body.should == "This is the new body"
    status.updated_at.should_not == timestamp
  end
  it "can destroy a status" do
    count = Status.count
    status = FactoryGirl.create(:status, :name => 'Delete Me')
    status.destroy
    Status.exists?(status.id).should be false
    Status.count.should be count
  end
end