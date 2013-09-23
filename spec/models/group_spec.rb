require 'spec_helper'

describe Group do
  # Check that gems are installed
  # Acts as Taggable on gem
  it { should have_many(:base_tags).through(:taggings) }

  # Rolify gem
  it { should have_many(:roles) }

  # Acts As Opengraph gem
  it { should respond_to(:opengraph_data) }

  # Paperclip gem
  it { should have_attached_file(:image) }

  # Check that appropriate fields are accessible
  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:public) }
  it { should allow_mass_assignment_of(:tag_list) }

  # Check that validations are happening properly
  it { should validate_presence_of(:name) }

  context 'Class Methods' do

    describe '#open_to_the_public' do
      include GroupsContext
      subject { Group.open_to_the_public }
      it { should include public_group }
      it { should_not include private_group }
    end
  end

end