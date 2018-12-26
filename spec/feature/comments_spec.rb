require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  let(:user) {FactoryBot.build(:user)}

  scenario "コメントの作成と削除" do

    sign_up_as user

    create_board

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
