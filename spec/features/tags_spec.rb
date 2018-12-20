require 'rails_helper'

RSpec.feature "Tags", type: :feature do
  scenario "タグの作成" do
    user = FactoryBot.build(:user)

    visit root_path
    click_link "アカウント登録"
    fill_in "User Name", with: user.name
    fill_in "Email Address", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: user.password
    click_button "アカウント登録"

    click_link "新規作成"
    fill_in "タイトル", with: "テストタイトル"
    fill_in "本文", with: "テストです。"
    click_button "保存"

    click_link "タグ新規作成"
    fill_in "タグ", with: "テストタグ"
    click_button "送信"
    expect(page).to have_content "タグを作成しました"
  end
end
