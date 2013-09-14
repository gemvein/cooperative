RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end

shared_context 'login support' do
  def sign_in(user)
    visit new_user_session_path
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button :sign_in.l
  end
end