require 'rails_helper'

RSpec.feature "Boards", type: :feature do
  let(:user) {FactoryBot.build(:user)}

  before do
    sign_up_as user
  end

  scenario "新しい記事を作成する" do

    expect {
      create_board

      expect(page).to have_content "投稿しました。"
      expect(page).to have_content "テストタイトル"
      expect(page).to have_content "#{user.name}"
    }.to change(Board, :count).by(1)

    click_link "詳細"

    expect(page).to have_content "テストタイトル"
    expect(page).to have_content "テストです。"
    expect(page).to have_content "#{user.name}"
  end

  scenario "記事を編集する" do

    create_board

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

    create_board

    expect {
      click_link "削除"
      expect(page).to have_content "削除しました。"
    }.to change(Board, :count).by(-1)
  end
end
