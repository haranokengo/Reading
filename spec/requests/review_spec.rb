RSpec.describe 'Reviewのリクエストのテスト', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:book) { FactoryBot.create(:book) }
  # 削除機能をテストするため事前評価にしている
  let!(:review) { FactoryBot.create(:review) }
  let(:category) { FactoryBot.create(:category) }

  before do
    post user_session_path, params: { user: { name: user.name, password: user.password } }
  end

  describe 'review機能のテスト' do
    it 'reviewを登録する' do
      expect do
        post book_reviews_path(book_isbn: book.isbn),
             params: { review: { content: review.content, category_id: category.id } }
      end.to change(Review, :count).by(1)
    end
    it 'reviewを削除する' do
      expect { review.destroy }.to change(Review, :count).by(-1)
    end
  end
end
