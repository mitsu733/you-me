require 'rails_helper'
RSpec.describe HomesController, type: :controller do
    describe 'アバウト' do
      context "アバウトページが正しく表示される" do
        before do
          get :about
        end
        it 'リクエストは200 OKとなること' do
          expect(response.status).to eq 200
        end
      end
    end

    describe 'トップ' do
      context "トップページが正しく表示される" do
        before do
          get :top
        end
        it 'リクエストは200 OKとなること' do
          expect(response.status).to eq 200
        end
      end
    end
end