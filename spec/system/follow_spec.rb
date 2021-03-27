# frozen_string_literal: true

RSpec.describe 'Relationshipのリクエストのテスト', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:athor_user) { FactoryBot.create(:user) }
  let(:relationship) { user.relationship.build(followed_id: other_user.id) }
  before {
    post user_session_path,params:{ user: {name:user.name,password:user.password}}
  }
  
  describe 'follow機能のテスト' do
    it 'フォローされていない場合、フォローする' do
     expect do
       post user_follow_path(user_id: user.id, id: athor_user.id), xhr: true
     end.to change(Relationship, :count).by(1)
    end
    it 'フォローされている場合、フォローを外す' do
      expect{ relationship.destroy }.to change{ Relationship.count }.by(-1)
    end
    
  end
end