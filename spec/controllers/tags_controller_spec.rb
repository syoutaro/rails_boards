require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let(:user) {FactoryBot.create(:user)}
  let(:tag_params) {FactoryBot.attributes_for(:tag)}

  describe "#create" do
    context "ログイン済みのユーザー" do
      it "タグを追加できること" do
        sign_in user
        expect {
          post :create, params: {tag: tag_params}
        }.to change(Tag, :count).by(1)
      end

      it "掲示板一覧にリダイレクトすること" do
        sign_in user
        post :create, params: {tag: tag_params}
        expect(response).to redirect_to root_path
      end
    end

    context "ログインしていないユーザー" do
      it "302レスポンスを返すこと" do
        post :create, params: {tag: tag_params}
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        post :create, params: {tag: tag_params}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
