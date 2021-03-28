RSpec.describe "Categoryのリクエストのテスト", type: :request do
  let(:category) { FactoryBot.create(:category) }

  context '管理者がログインしている場合' do
    before do
      post admin_admin_session_path, params: { admin: { name: "test", password: "testtest" } }
    end

    it 'カテゴリーの新規投稿' do
      expect do
        post admin_categories_path, params: { category: category.name }
      end.to change(Category, :count).by(1)
    end
  end
end
