require 'spec_helper'

describe User do
  it 'has a valid factory'do
    FactoryGirl.create(:user).should be_valid
  end
  it 'is invalid without a nickname' do
    user = FactoryGirl.build(:user)
    user.nickname = nil
    if user.save && !user.reload.nickname
      fail "is not invalid without a nickname"
    end
  end
  it 'uses the nickname as the parameter method' do
    user = FactoryGirl.create(:user)
    user.to_param.should be user.nickname
  end
end