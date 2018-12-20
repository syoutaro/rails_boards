require 'rails_helper'

RSpec.feature "Boards", type: :feature do
  scenario "新しい記事を作成する" do
    user = FactoryBot.build(:user)

    visit root_path
    click_link "アカウント登録"
    fill_in "User Name", with: user.name
    fill_in "Email Address", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password Confirmation", with: user.password
    click_button "アカウント登録"

    expect {
      click_link "新規作成"
      fill_in "タイトル", with: "テストタイトル"
      fill_in "本文", with: "テストです。"
      click_button "保存"

      expect(page).to have_content "投稿しました。"
      expect(page).to have_content "テストタイトル"
      expect(page).to have_content "#{user.name}"
    }.to change(Board, :count).by(1)
  end

  scenario "記事を編集する" do
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

    click_link "編集"
    fill_in "タイトル", with: "新タイトル"
    fill_in "本文", with: "編集のテストです。"
    click_button "保存"

    expect(page).to have_content "編集しました。"
    click_link "詳細"
    expect(page).to have_content "新タイトル"
    expect(page).to have_content "編集のテストです。"
  end

  scenario "記事を削除する" do
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

    expect {
      click_link "削除"
      expect(page).to have_content "削除しました。"
    }.to change(Board, :count).by(-1)
  end
end
