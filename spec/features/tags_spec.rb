require 'rails_helper'

RSpec.feature "Tags", type: :feature do
  scenario "タグの作成" do
    user = FactoryBot.build(:user)

    sign_up_as user

    create_board

    click_link "タグ新規作成"
    fill_in "タグ", with: "テストタグ"
    click_button "送信"
    expect(page).to have_content "タグを作成しました"
  end
end
