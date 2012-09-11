require 'spec_helper'

describe "Layout" do
  include_context 'load site'
  include RSpec::Rails::RequestExampleGroup
  it "looks like a bootstrap layout" do
    get '/'
    assert_select '.navbar', 1
    assert_select '.container', :minimum => 1
  end
  
  it "should show the configured application name" do
    get '/'
    assert_select '.brand', Cooperative.configuration.application_name
  end
end
