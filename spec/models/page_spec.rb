require 'spec_helper'

describe Page do
  # Check that gems are installed
  # PrivatePerson gem
  it { should have_many :permissions}
  # Public Activity gem
  it { should have_many(:activities) }
  # Friendly ID gem
  it { should respond_to(:friendly_id) }
  # Acts as Taggable on gem
  it { should have_many(:base_tags).through(:taggings) }
  # Acts As Opengraph gem
  it { should respond_to(:opengraph_data) }

  # Check that appropriate fields are accessible
  it { should allow_mass_assignment_of(:body) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:keywords) }
  it { should allow_mass_assignment_of(:public) }
  it { should allow_mass_assignment_of(:title) }
  it { should allow_mass_assignment_of(:parent_id) }
  it { should allow_mass_assignment_of(:tag_list) }

  # Check that validations are happening properly
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  # Check relationships
  it { should belong_to(:pageable) }
  it { should belong_to(:parent) }
  it { should have_many(:children) }

  context 'Class Methods' do
    include_context 'pages support'

    describe '#find_all_root_pages' do
      subject { Page.find_all_root_pages }
      it { should include root_parent_page }
      it { should include root_child_page }
      it { should include root_grandchild_page }
      it { should_not include owned_parent_page }
      it { should_not include owned_child_page }
      it { should_not include owned_grandchild_page }
    end

    describe '#find_all_owned_pages' do
      subject { Page.find_all_owned_pages }
      it { should_not include root_parent_page }
      it { should_not include root_child_page }
      it { should_not include root_grandchild_page }
      it { should include owned_parent_page }
      it { should include owned_child_page }
      it { should include owned_grandchild_page }
    end

    describe '#find_all_by_path' do
      context 'when valid' do
        context 'parent' do
          subject { Page.find_all_by_path('parent') }
          it { should include root_parent_page }
          it { should include owned_parent_page }
          it { should_not include root_child_page }
          it { should_not include owned_child_page }
        end

        context 'child' do
          subject { Page.find_all_by_path('parent/child') }
          it { should_not include root_parent_page }
          it { should_not include owned_parent_page }
          it { should include root_child_page }
          it { should include owned_child_page }
        end

        context 'grandchild' do
          subject { Page.find_all_by_path('parent/child/grandchild') }
          it { should_not include root_child_page }
          it { should_not include owned_child_page }
          it { should include root_grandchild_page }
          it { should include owned_grandchild_page }
        end
      end
      context 'when invalid' do
        context 'foobar' do
          subject { Page.find_all_by_path('foobar') }
          it { should eq [] }
        end
      end
    end


    describe '#find_by_path' do
      context 'when valid' do
        context 'root parent' do
          subject { Page.find_all_root_pages.find_by_path('parent') }
          it { should eq root_parent_page }
        end

        context 'root child' do
          subject { Page.find_all_root_pages.find_by_path('parent/child') }
          it { should eq root_child_page }
        end

        context 'owned parent' do
          subject { page_owner.pages.find_by_path('parent') }
          it { should eq owned_parent_page }
        end

        context 'owned child' do
          subject {
            Page.where(:pageable_type => 'User').find_by_path('parent/child') }
          it { should eq owned_child_page }
        end
      end
      context 'when invalid' do
        context 'foobar' do
          subject { Page.find_by_path('foobar') }
          it { should be nil }
        end
      end
    end

  end

  context 'Instance Methods' do
    include_context 'pages support'

    describe '#should_generate_new_friendly_id?' do
      context 'when new' do
        subject { FactoryGirl.build(:page).should_generate_new_friendly_id? }
        it { should be true }
      end
      context 'when not new' do
        subject { root_parent_page.should_generate_new_friendly_id? }
        it { should be false }
      end
    end

    describe '#ancestry' do
      context 'parent' do
        subject { root_parent_page.ancestry }
        it { should eq [] }
      end

      context 'child' do
        subject { root_child_page.ancestry }
        it { should eq [root_parent_page] }
      end

      context 'grandchild' do
        subject { root_grandchild_page.ancestry }
        it { should eq [root_parent_page, root_child_page] }
      end
    end

    describe '#path_parts' do
      context 'parent' do
        subject { root_parent_page.path_parts }
        it { should eq ['parent'] }
      end

      context 'child' do
        subject { root_child_page.path_parts }
        it { should eq ['parent', 'child'] }
      end

      context 'grandchild' do
        subject { root_grandchild_page.path_parts }
        it { should eq ['parent', 'child', 'grandchild'] }
      end
    end

    describe '#path' do
      context 'when a root page' do
        context 'parent' do
          subject { root_parent_page.path }
          it { should eq '/pages/parent' }
        end

        context 'child' do
          subject { root_child_page.path }
          it { should eq '/pages/parent/child' }
        end

        context 'grandchild' do
          subject { root_grandchild_page.path }
          it { should eq '/pages/parent/child/grandchild' }
        end
      end
      context 'when an owned page' do
        context 'parent' do
          subject { owned_parent_page.path }
          it { should eq '/people/' + page_owner.nickname + '/pages/parent' }
        end

        context 'child' do
          subject { owned_child_page.path }
          it { should eq '/people/' + page_owner.nickname + '/pages/parent/child' }
        end

        context 'grandchild' do
          subject { owned_grandchild_page.path }
          it { should eq '/people/' + page_owner.nickname + '/pages/parent/child/grandchild' }
        end
      end
    end

  end

end