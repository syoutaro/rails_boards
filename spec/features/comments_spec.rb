require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  scenario "コメントの作成と削除" do
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

    click_link "詳細"
    expect {
      fill_in "コメント", with: "テストのコメント"
      click_button "送信"
      expect(page).to have_content "コメントを投稿しました"
    }.to change(Comment, :count).by(1)

    expect {
      click_link "削除"
      expect(page).to have_content "コメントを削除しました"
    }.to change(Comment, :count).by(-1)
  end
end
