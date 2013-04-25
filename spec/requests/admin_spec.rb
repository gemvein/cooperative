require 'spec_helper'

describe "Admin" do
  include_context "login request"
  include_context "load site"

  it "requires login" do
    get rails_admin.dashboard_path
    response.should redirect_to new_user_session_path
  end
end
