shared_context "login request" do
  def sign_in(user)
    visit new_user_session_path
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button :sign_in.l
  end
  
  def sign_in_as_admin(user)
    user.is_admin
    sign_in user
  end
end
