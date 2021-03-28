RSpec.describe 'PostCommentのリクエストのテスト', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:review) { FactoryBot.create(:review) }
  # 削除機能をテストするため事前評価にしている
  let!(:post_comment) { FactoryBot.create(:post_comment) }

  before do
    post user_session_path, params: { user: { name: user.name, password: user.password } }
  end

  describe 'post_comment機能のテスト' do
    it 'コメントを登録する' do
      expect do
        post review_post_comments_path(review_id: review.id), params: {
          post_comment: { impression: post_comment.impression },
        },
                                                              xhr: true
      end.to change(PostComment, :count).by(1)
    end
    it 'コメントを削除する' do
      expect { post_comment.destroy }.to change(PostComment, :count).by(-1)
    end
  end
end
