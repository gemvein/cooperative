require 'spec_helper'

describe "Statuses" do
  include_context "statuses support"
  include_context "login support for requests"
  it "shows individual statuses" do
    sign_in(@following_user)
    visit cooperative.status_path(@statuses.first)

    current_url.should eq cooperative.status_url(@statuses.first)
  end
end
