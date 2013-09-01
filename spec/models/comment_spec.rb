require 'spec_helper'

describe Comment do
  # Check that appropriate fields are accessible
  it { should allow_mass_assignment_of(:body) }
  it { should allow_mass_assignment_of(:commentable_id) }
  it { should allow_mass_assignment_of(:commentable_type) }

  # Check that validations are happening properly
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:commentable) }

  # Check relationships
  it { should belong_to(:user) }
  it { should belong_to(:commentable) }

end