require 'spec_helper'

describe Role do
  # Check relationships
  it { should have_and_belong_to_many(:users) }
  it { should belong_to(:resource) }
end