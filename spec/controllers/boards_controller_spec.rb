require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  let(:user) {FactoryBot.create(:user)}

  describe "#index" do
    context "ログイン済みのユーザとして" do
      it "200レスポンスを返すこと" do
        sign_in user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしていないユーザーとして" do
      it "200レスポンスを返すこと" do
        get :index
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#new" do
    context "ログイン済みのユーザとして" do
      before do
        @board = FactoryBot.create(:board, owner: user)
      end

      it "200レスポンスを返すこと" do
        sign_in user
        get :new, params: {id: @board.id}
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしていないユーザーとして" do
      before do
        other_user = FactoryBot.create(:user)
        @board = FactoryBot.create(:board, owner: other_user)
      end

      it "302レスポンスを返すこと" do
        get :new, params: {id: @board.id}
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        get :new, params: {id: @board.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#create" do
    context "ログイン済みのユーザとして" do
      it "掲示板の記事を追加できること" do
        board_params = FactoryBot.attributes_for(:board)
        sign_in user
        expect {
          post :create, params: {board: board_params}
        }.to change(user.boards, :count).by(1)
      end

      it "掲示板一覧にリダイレクトすること" do
        board_params = FactoryBot.attributes_for(:board)
        sign_in user
        post :create, params: {board: board_params}
        expect(response).to redirect_to root_path
      end
    end

    context "ログインしていないユーザーとして" do
      it "302レスポンスを返すこと" do
        board_params = FactoryBot.attributes_for(:board)
        post :create, params: {board: board_params}
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        board_params = FactoryBot.attributes_for(:board)
        post :create, params: {board: board_params}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#show" do
    context "ログイン済みのユーザとして" do
      before do
        @board = FactoryBot.create(:board, owner: user)
      end

      it "200レスポンスを返すこと" do
        sign_in user
        get :show, params: {id: @board.id}
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしていないユーザーとして" do
      before do
        other_user = FactoryBot.create(:user)
        @board = FactoryBot.create(:board, owner: other_user)
      end

      it "200レスポンスを返すこと" do
        get :show, params: {id: @board.id}
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#edid" do
    context "認可されたユーザーとして" do
      before do
        @board = FactoryBot.create(:board, owner: user)
      end

      it "200レスポンスを返すこと" do
        sign_in user
        get :edit, params: {id: @board.id}
        expect(response).to have_http_status "200"
      end
    end

    context "認可されていないユーザーとして" do
      before do
        other_user = FactoryBot.create(:user)
        @board = FactoryBot.create(:board, owner: other_user)
      end

      it "レスポンスがRecordNotFound" do
        sign_in user
        expect {
          get :edit, params: {id: @board.id}
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "#update" do
    context "認可されたユーザーとして" do
      before do
        @board = FactoryBot.create(:board, owner: user)
      end

      it "掲示板の記事を更新できること" do
        board_params = FactoryBot.attributes_for(:board,
          title: "New Title", body: "New Body")
        sign_in user
        patch :update, params: {id: @board.id,
          board: board_params}
        expect(@board.reload.title).to eq"New Title"
        expect(@board.reload.body).to eq"New Body"
      end

      it "編集ページにリダイレクトすること" do
        board_params = FactoryBot.attributes_for(:board)
        sign_in user
        patch :update, params: {id: @board.id,
          board: board_params}
        expect(response).to redirect_to edit_board_path
      end
    end

    context "認可されていないユーザーとして" do
      before do
        other_user = FactoryBot.create(:user)
        @board = FactoryBot.create(:board, owner: other_user,
          title: "Some Old Title", body: "Some Old body")
      end

      it "掲示板の記事を更新できないこと" do
        board_params = FactoryBot.attributes_for(:board,
          title: "New Title", body: "New Body")
        sign_in user
        expect {
          patch :update, params: {id: @board.id,
          board: board_params}
          }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context "ログインしていないユーザーとして" do
      before do
        @board = FactoryBot.create(:board)
      end

      it "302レスポンスを返す" do
        board_params = FactoryBot.attributes_for(:board)
        patch :update, params: {id: @board.id, board: board_params}
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトする" do
        board_params = FactoryBot.attributes_for(:board)
        patch :update, params: {id: @board.id, board: board_params}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#destroy" do
    context "認可されたユーザーとして" do
      before do
        @board = FactoryBot.create(:board, owner: user)
      end

      it "掲示板の記事を削除できること" do
        sign_in user
        expect {
          delete :destroy, params: {id: @board.id}
        }.to change(user.boards, :count).by(-1)
      end

      it "掲示板一覧にリダイレクトすること" do
        sign_in user
        delete :destroy, params: {id: @board.id}
        expect(response).to redirect_to root_path
      end
    end

    context "認可されていないユーザーとして" do
      before do
        other_user = FactoryBot.create(:user)
        @board = FactoryBot.create(:board, owner: other_user)
      end

      it "掲示板の記事を削除できないこと" do
        sign_in user
        expect {
          delete :destroy, params: {id: @board.id}
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context "ログインしていないユーザーとして" do
      before do
        @board = FactoryBot.create(:board)
      end

      it "302レスポンスを返すこと" do
        delete :destroy, params: {id: @board.id}
        expect(response).to have_http_status "302"
      end

      it "サインイン画面にリダイレクトすること" do
        delete :destroy, params: {id: @board.id}
        expect(response).to redirect_to "/users/sign_in"
      end

      it "掲示板の記事を削除できないこと" do
        expect {
          delete :destroy, params: {id: @board.id}
        }.to_not change(Board, :count)
      end
    end
  end

end
