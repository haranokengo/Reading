
RSpec.describe 'PostCommentのリクエストのテスト', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:review) { FactoryBot.create(:review) }
  let!(:post_comment) { FactoryBot.create(:post_comment) }
  before {
    post user_session_path,params:{ user: { name: user.name,password: user.password }}
  }

  describe 'post_comment機能のテスト' do
    it 'コメントを登録する' do
      expect do
        post review_post_comments_path(review_id: review.id), xhr: true,
        params:{ post_comment: {impression: post_comment.impression }}
      end.to change{ PostComment.count }.by(1)
    end
    it 'コメントを削除する' do
      expect{ post_comment.destroy }.to change{ PostComment.count }.by(-1)
    end
  end
end