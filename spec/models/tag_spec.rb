require 'spec_helper'

describe User do
  # Check that gems are installed
  # Acts as Taggable on gem
  it { should have_many(:taggings) }
  # Friendly ID gem
  it { should respond_to(:friendly_id) }
  # Acts As Opengraph gem
  it { should respond_to(:opengraph_data) }

  context 'Class Methods' do
    include_context 'tags support'

    describe '#total_item_counts' do
      subject { Tag.total_item_counts }
      it { should include({:name => 'reading', :count => 5})}
      it { should include({:name => 'apprehension', :count => 3})}
      it { should include({:name => 'disco', :count => 1})}

    end

  end

  context 'Instance Methods' do
    include_context 'tags support'

    describe '#recent_users' do
      subject { reading_tag.recent_users }
      it { should eq [tagged_on_skills_trip, tagged_on_skills_dup, tagged_on_skills_user] }
      it { should_not eq [tagged_on_skills_user, tagged_on_skills_dup, tagged_on_skills_trip] }
    end

    describe '#users_tagged_with' do
      subject { reading_tag.users_tagged_with }
      it { should eq [tagged_on_skills_user, tagged_on_skills_dup, tagged_on_skills_trip] }
      it { should_not eq [tagged_on_skills_trip, tagged_on_skills_dup, tagged_on_skills_user] }
    end

  end

end