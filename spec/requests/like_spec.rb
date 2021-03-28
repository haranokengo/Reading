RSpec.describe 'likeのリクエストのテスト', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book) }
  # お気に入りをはずず機能をテストするため事前評価にしている
  let!(:like) { FactoryBot.create(:like) }

  before do
    post user_session_path, params: { user: { name: user.name, password: user.password } }
  end

  describe 'お気に入りのテスト' do
    it "お気に入りしていない場合、お気に入りができること" do
      expect do
        post book_likes_path(book_id: book.id), xhr: true
      end.to change(Like, :count).by(1)
    end
    it "お気に入りしている場合、お気に入りを外す" do
      expect { like.destroy }.to change(Like, :count).by(-1)
    end
  end
end
