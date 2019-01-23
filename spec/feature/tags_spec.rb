require 'rails_helper'

RSpec.feature "Tags", type: :feature do
  let(:user) {FactoryBot.build(:user)}
  before do
    sign_up_as user
  end

  scenario "タグの作成" do

    create_board

    click_link "タグ新規作成"
    fill_in "タグ", with: "テストタグ"
    expect {
      click_button "送信"
      expect(page).to have_content "タグを作成しました"
    }.to change(Tag, :count).by(1)
  end
end
