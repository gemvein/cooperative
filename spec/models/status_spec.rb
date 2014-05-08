require 'spec_helper'

describe Status do
  # Check that gems are installed
  # PrivatePerson gem
  it { should have_many :permissions }
  # Acts as Taggable on gem
  it { should have_many(:base_tags).through(:taggings) }
  # Coletivo gem
  it { should have_many(:person_ratings) }
  # Paperclip gem
  it { should have_attached_file(:image) }

  # Check that validations are happening properly
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:body) }

  # Check relationships
  it { should belong_to(:shareable) }
  it { should belong_to(:user) }
  it { should have_many(:statuses) }
  it { should have_many(:comments) }

  context 'Instance Methods' do
    include_context 'statuses support'

    describe '#build_status' do
      subject { unshared_status.build_status }
      it { should be_a_new Status }
      its(:shareable) { should be unshared_status }
    end

    describe '#image_remote_url=' do
      subject { imaged_status.image_file_name }
      it { should eq 'hqdefault.jpg' }
    end

    describe '#path' do
      subject { unshared_status.path }
      it { should eq '/statuses/' + unshared_status.id.to_s  }
    end

    describe '#tokenize_tags' do
      subject { tagged_status.tags }
      it { should have_exactly(3).items }
    end

    describe '#tokenize_mentions' do
      subject { mentioning_status }
      it { should have_exactly(3).activities }
    end

  end

end