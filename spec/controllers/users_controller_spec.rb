require 'rails_helper'

describe UsersController, type: :controller do

  describe 'Get #show' do
    before do
      @user = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:random_user)
    end

    context 'When a user is logged in' do
      before do
        sign_in @user
      end
      it 'loads correct user details' do
        get :show, params: { id: @user.id }
        expect(assigns(:user)).to eq @user
        expect(response).to be_ok
      end
      it 'cant access other users show page' do
        get :show, params: { id: @user2.id }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'When a user is not logged in' do
      it 'redirects to loggin' do
        get :show, params: { id: @user.id }
        expect(response).to redirect_to(root_path)
      end
    end

  end
end
