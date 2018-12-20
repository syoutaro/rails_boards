require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe "#create" do
    before do
      @user = FactoryBot.create(:user)
    end

    context "ログイン済みのユーザー" do
      it "タグを追加できること" do
        tag_params = FactoryBot.attributes_for(:tag)
        sign_in @user
        expect {
          post :create, params: {tag: tag_params}
        }.to change(Tag, :count).by(1)
      end

      it "掲示板一覧にリダイレクトすること" do
        tag_params = FactoryBot.attributes_for(:tag)
        sign_in @user
        post :create, params: {tag: tag_params}
        expect(response).to redirect_to root_path
      end
    end

    context "ログインしていないユーザー" do
      it "302レスポンスを返すこと" do
        tag_params = FactoryBot.attributes_for(:tag)
        post :create, params: {tag: tag_params}
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        tag_params = FactoryBot.attributes_for(:tag)
        post :create, params: {tag: tag_params}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
end
