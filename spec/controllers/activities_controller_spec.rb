require 'spec_helper'

describe ActivitiesController do
  include_context "activities support"
  describe "GET index" do
    it "gets the followed @peoples' @activities and renders the index template" do
      sign_in :user, @following_user
      get :index
      expect(:activities).to have_at_least(5).items
      response.should render_template("index")
    end
  end
end