RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end

shared_context 'login support' do
  def sign_in_as(user)
    visit user_session_path
    within '#new_user' do
      fill_in 'user_email', :with => user.email
      fill_in 'user_password', :with => user.password
      click_button :sign_in.l
    end
    expect(page).to have_content 'Signed in successfully.'
  end
end

