require 'spec_helper'

describe "Admin" do
  include_context "login support for requests"
  include_context "pages support"

  it "requires login" do
    get rails_admin.dashboard_path
    response.should redirect_to new_user_session_path
  end
end
