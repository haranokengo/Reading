# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PostCommentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post_comment.valid? }

    let(:user) { create(:user) }
    let!(:post_comment) { build(:post_comment, user_id: user.id) }

    context 'impressionカラム' do
      it '空欄でないこと' do
        post_comment.impression = ''
        is_expected.to eq false
      end
      it 'impressionカラムが空だとエラーメッセージが表示される' do
        post_comment.impression = ''
        post_comment.valid?
        expect(post_comment.errors.full_messages).to include("コメントが入力されていません。","コメントは10文字以上に設定して下さい。")
      end
      it '10文字以上であること: 9文字は×' do
        post_comment.impression = Faker::Lorem.characters(number: 9)
        is_expected.to eq false
      end
      it '10文字以上であること: 10文字は〇' do
        post_comment.impression = Faker::Lorem.characters(number: 10)
        is_expected.to eq true
      end
      it '10文字以下の場合エラーメッセージが表示される' do
        post_comment.impression = Faker::Lorem.characters(number: 9)
        post_comment.valid?
        expect(post_comment.errors.full_messages).to include("コメントは10文字以上に設定して下さい。")
      end
      it '150文字以下であること: 150文字は〇' do
        post_comment.impression = Faker::Lorem.characters(number: 150)
        is_expected.to eq true
      end
      it '150文字以下であること: 151文字は×' do
        post_comment.impression = Faker::Lorem.characters(number: 151)
        is_expected.to eq false
      end
      it '150文字以上の場合エラーメッセージが表示される' do
        post_comment.impression = Faker::Lorem.characters(number: 151)
        post_comment.valid?
        expect(post_comment.errors.full_messages).to include("コメントは150文字以下に設定して下さい。")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Reviewモデルとの関係' do
      it '1:Nとなっている' do
        expect(PostComment.reflect_on_association(:review).macro).to eq :belongs_to
      end
    end
    context 'Userモデルとの関係' do
      it '1:Nとなっている' do
        expect(PostComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end