require 'spec_helper'

describe "Cooperative" do
  it 'should return correct version string' do
    Cooperative.version_string.should == "Cooperative version #{Cooperative::VERSION}"
  end
end