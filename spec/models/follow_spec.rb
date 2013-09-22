require 'spec_helper'

describe Follow do
  # Check that gems are installed
  # Authorization gem
  it { should respond_to(:blocked) }

  # Check relationships
  it { should belong_to(:followable) }
  it { should belong_to(:follower) }

  context 'Class Methods' do
    require Gem.loaded_specs['cooperative'].full_gem_path + '/spec/support/followers_support'
    extend Followers
    describe '.to_json' do
      subject { Follow.to_json }
      it { should be_a String }
      it { should match /^\[.*\]$/ }
    end
  end

  context 'Instance Methods' do
    require Gem.loaded_specs['cooperative'].full_gem_path + '/spec/support/followers_support'
    extend Followers
    describe '#block!' do
      subject {
        follow = Follow.for_follower(blockable_user).first
        follow.block!
        follow.reload
        follow.blocked
      }
      it { should be true }
    end
  end
end