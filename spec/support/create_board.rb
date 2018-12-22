module CreateBoard
  def create_board
    click_link "新規作成"
    fill_in "タイトル", with: "テストタイトル"
    fill_in "本文", with: "テストです。"
    click_button "保存"
  end
end

RSpec.configure do |config|
  config.include CreateBoard
end