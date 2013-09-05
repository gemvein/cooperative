require 'spec_helper'

describe Group do
  # Check that gems are installed
  # Acts as Taggable on gem
  it { should have_many(:base_tags).through(:taggings) }

  # Check that appropriate fields are accessible
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:public) }
  it { should allow_mass_assignment_of(:tag_list) }

  # Check that validations are happening properly
  it { should validate_presence_of(:name) }

  context 'Class Methods' do

    describe '#open_to_the_public' do
      include_context 'groups support'

      subject { Group.open_to_the_public }
      it { should include public_group }
      it { should_not include private_group }
    end

  end

end