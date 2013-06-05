require 'spec_helper'

describe Users::RegistrationsController do
  include_context "people support"
  describe "POST create (person/nickname/pages)" do
    it 'gives a badge on signup' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :create, :user => {}
      assigns(:user).should be_a_new(User)
    end
  end
end