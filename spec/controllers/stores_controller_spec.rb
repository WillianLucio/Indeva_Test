require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryBot.create(:user)
    sign_in @current_user
  end

  describe "GET #index" do
    context "user is owner the stores" do
      before(:each) do
        create(:store)
        create(:store)
        @store = create(:store, user: @current_user)
        @store2 = create(:store, user: @current_user)

        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns only user stores" do
        expect(assigns(:stores).size).to eq(2)
        expect(assigns(:stores)[0].id).to eq(@store.id)
        expect(assigns(:stores)[1].id).to eq(@store2.id)
      end
    end
  end

  describe "GET #show" do
    context "user is owner" do
      before(:each) do
        @store = create(:store, user: @current_user)
        get :show, params: {id: @store.id}
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "correct store information" do
        expect(assigns(:store).id).to eql(@store.id)
        expect(assigns(:store).name).to eql(@store.name)
        expect(assigns(:store).user).to eql(@store.user)
      end
    end

    it "user is not owner" do
      store = create(:store)
      get :show, params: {id: store.id}
      expect(assigns(:store).id).to eql(nil)
    end
  end

  describe "GET #create" do
    context "with data correct" do
      before(:each) do
        @store = build(:store, user: @current_user)
        post :create, params: {store: @store.attributes}
      end

      it "redirect for /stores" do
        expect(response).to redirect_to('/stores')
      end

      it "store created with datas correct" do
        expect(Store.last.name).to eql(@store.name)
        expect(Store.last.user).to eql(@store.user)
      end
    end

    it "returns status 400 with the wrong data" do
      store = build(:store, name: "", user: @current_user)
      post :create, params: {store: store.attributes}
      expect(response).to have_http_status(422)
    end

    it "status 422 with name store is repeated" do
      store = build(:store, name: "Indeva", user: @current_user)
      post :create, params: {store: store.attributes}
      post :create, params: {store: store.attributes}
      expect(response).to have_http_status(422)
    end
  end

  describe "GET #update" do
    context "user is owner" do
      before(:each) do
        @store = create(:store, user: @current_user)
        @store_attributes = attributes_for(:store)
        put :update, params: {id: @store.id, store: @store_attributes}
      end

      it "redirect to /store" do
        expect(response).to redirect_to('/stores')
      end

      it "the data was updated correctly" do
        expect(Store.last).to have_attributes(@store_attributes)
      end
    end
  end

  describe "GET #destroy" do
    context "user is owner" do
      before(:each) do
        @store = create(:store, user: @current_user)
        delete :destroy, params: {id: @store.id}
      end

      it "redirec to /store" do
        expect(response).to redirect_to('/stores')
      end

      it "the store was deleted" do
          expect(Store.all).to_not include(@store)
      end
    end
  end

end
