RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it 'nameカラムが空だとエラーメッセージがでる' do
        user.name = ''
        user.valid?
        expect(user.errors.full_messages).to include("名前が入力されていません。", "名前は2文字以上に設定して下さい。")
      end
      it '2文字以上であること: 1文字は×' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '2文字以下の場合エラーメッセージが表示される' do
        user.name = Faker::Lorem.characters(number: 1)
        user.valid?
        expect(user.errors.full_messages).to include("名前は2文字以上に設定して下さい。")
      end
      it '20文字以下であること: 20文字は〇' do
        user.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        user.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it '20文字以上の場合エラーメッセージが表示される' do
        user.name = Faker::Lorem.characters(number: 21)
        user.valid?
        expect(user.errors.full_messages).to include("名前は20文字以下に設定して下さい。")
      end
    end

    context 'nicknameカラム' do
      it '空欄でないこと' do
        user.nickname = ''
        is_expected.to eq false
      end
      it 'nicknameカラムが空だとエラーメッセージが表示される' do
        user.nickname = ''
        user.valid?
        expect(user.errors.full_messages).to include("ニックネームが入力されていません。", "ニックネームは2文字以上に設定して下さい。")
      end
      it '2文字以上であること: 1文字は×' do
        user.nickname = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        user.nickname = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '2文字以下の場合エラーメッセージが表示される' do
        user.nickname = Faker::Lorem.characters(number: 1)
        user.valid?
        expect(user.errors.full_messages).to include("ニックネームは2文字以上に設定して下さい。")
      end
      it '20文字以下であること: 20文字は〇' do
        user.nickname = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        user.nickname = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it '20文字以上の場合エラーメッセージが表示される' do
        user.nickname = Faker::Lorem.characters(number: 21)
        user.valid?
        expect(user.errors.full_messages).to include("ニックネームは20文字以下に設定して下さい。")
      end
      it '一意性があること' do
        user.nickname = other_user.nickname
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Reviewモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:reviews).macro).to eq :has_many
      end
    end
  end
end
