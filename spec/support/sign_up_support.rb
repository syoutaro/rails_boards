  module SignUpSupport
    def sign_up_as(user)
      visit root_path
      click_link "アカウント登録"
      fill_in "User Name", with: user.name
      fill_in "Email Address", with: user.email
      fill_in "Password", with: user.password
      fill_in "Password Confirmation", with: user.password
      click_button "アカウント登録"
    end
  end

  RSpec.configure do |config|
    config.include SignUpSupport
  end