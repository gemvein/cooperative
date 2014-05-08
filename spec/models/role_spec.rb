require 'spec_helper'

describe Role do
  # Check that appropriate fields are accessible
  it { should allow_mass_assignment_of(:authorizable) }
  it { should allow_mass_assignment_of(:authorizable_type) }
  it { should allow_mass_assignment_of(:authorizable_id) }
  it { should allow_mass_assignment_of(:name) }

  # Check that validations are happening properly
  it { should validate_presence_of(:name) }

  # Check relationships
  it { should have_and_belong_to_many(:user) }
  it { should belong_to(:authorizable) }
end