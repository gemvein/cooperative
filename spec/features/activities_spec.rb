require 'spec_helper'

feature 'Activities browsing' do
  include_context 'login support'
  include_context 'activities support'

  describe 'User visits the activities page' do
    it_should_behave_like 'a cooperative page', '/'

  end

end