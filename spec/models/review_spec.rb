# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reviewモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { review.valid? }

    let(:user) { create(:user) }
    let!(:review) { build(:review, user_id: user.id) }
    
    context 'contentカラム' do
      it '空欄でないこと' do
        review.content = ''
        is_expected.to eq false
      end
      it '10文字以上であること: 9文字は×' do
        review.content = Faker::Lorem.characters(number: 9)
        is_expected.to eq false
      end
      it '10文字以上であること: 10文字は〇' do
        review.content = Faker::Lorem.characters(number: 10)
        is_expected.to eq true
      end
      it '10文字以下の場合エラーメッセージが表示される' do
        review.content = Faker::Lorem.characters(number: 9)
        review.valid?
        expect(review.errors.full_messages).to include("投稿内容は10文字以上に設定して下さい。")
      end
      it '150文字以下であること: 150文字は〇' do
        review.content = Faker::Lorem.characters(number: 150)
        is_expected.to eq true
      end
      it '150文字以下であること: 151文字は×' do
        review.content = Faker::Lorem.characters(number: 151)
        is_expected.to eq false
      end
      it '150文字以上の場合エラーメッセージが表示される' do
        review.content = Faker::Lorem.characters(number: 151)
        review.valid?
        expect(review.errors.full_messages).to include("投稿内容は150文字以下に設定して下さい。")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Review.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Bookモデルとの関係' do
      it 'N:1となっている' do
        expect(Review.reflect_on_association(:book).macro).to eq :belongs_to
      end
    end
  end
end