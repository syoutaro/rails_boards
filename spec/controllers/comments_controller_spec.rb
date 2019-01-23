require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) {FactoryBot.create(:user)}
  let(:board) {FactoryBot.create(:board, owner: user)}

  describe "#create" do
    context "ログイン済みのユーザーとして" do
      it "コメントを追加できること" do
        comment_params = FactoryBot.build(:comment).attributes
        sign_in user
        expect {
          post :create, params: {comment: comment_params, board_id: board.id}
        }.to change(user.comments, :count).by(1)
      end
    end

    context "ログインしていないユーザーとして" do
      it "302レスポンスを返すこと" do
        comment_params = FactoryBot.attributes_for(:comment)
        post :create, params: {comment: comment_params}
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        comment_params = FactoryBot.attributes_for(:comment)
        post :create, params: {comment: comment_params}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#destroy" do
    context "認可されたユーザーとして" do
      before do
        @comment = FactoryBot.create(:comment, owner: user)
      end

      it "コメントを削除できること" do
        sign_in user
        expect {
          delete :destroy, params: {id: @comment.id}
        }.to change(user.comments, :count).by(-1)
      end
    end

    context "認可されていないユーザーとして" do
      before do
        other_user = FactoryBot.create(:user)
        @comment = FactoryBot.create(:comment, owner: other_user)
      end

      it "コメントを削除できないこと" do
        sign_in user
        expect {
          delete :destroy, params: {id: @comment.id}
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context "ログインしていないユーザーとして" do
      before do
        @comment = FactoryBot.create(:comment)
      end

      it "302レスポンスを返すこと" do
        delete :destroy, params: {id: @comment.id}
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        delete :destroy, params: {id: @comment.id}
        expect(response).to redirect_to new_user_session_path
      end

      it "コメントを削除できないこと" do
        expect {
          delete :destroy, params: {id: @comment.id}
        }.to_not change(Comment, :count)
      end
    end
  end
end
