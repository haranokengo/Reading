RSpec.describe 'favoriteのリクエストテスト', type: :request do
  let!(:review) { FactoryBot.create(:review) }
  let!(:user) { FactoryBot.create(:user, password: 'password') }
  let!(:favorite) { FactoryBot.create(:favorite) }
  before {
    post user_session_path,params:{ user: {name:user.name,password:user.password}}
  }

  describe 'いいねのテスト' do
    it "いいねされていない場合、いいねができる" do
      expect do
        post review_favorites_path(review_id: review.id), xhr: true
      end.to change(Favorite, :count).by(1)
    end
    it "いいねされている場合、いいねが削除される" do
      expect { favorite.destroy }.to change{ Favorite.count }.by(-1)
    end
  end
end
