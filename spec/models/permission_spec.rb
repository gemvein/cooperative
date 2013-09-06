require 'spec_helper'

describe Permission do
  # Check that appropriate fields are accessible
  it { should allow_mass_assignment_of(:permissible) }
  it { should allow_mass_assignment_of(:permissible_type) }
  it { should allow_mass_assignment_of(:permissible_id) }
  it { should allow_mass_assignment_of(:whom) }

  # Check that validations are happening properly
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:permissible_type) }
  it { should validate_presence_of(:whom) }

  # Check relationships
  it { should belong_to(:user) }
  it { should belong_to(:permissible) }
end