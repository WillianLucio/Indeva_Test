require 'rails_helper'

RSpec.describe SellersController, type: :controller do
  include Devise::Test::ControllerHelpers

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = FactoryBot.create(:user)
    sign_in @current_user
  end

  describe "GET #show" do
    before(:each) do
      @store = create(:store, user: @current_user)
      @seller = create(:seller, store: @store)
      get :show, params: {id: @seller.id}
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "correct seller information" do
      expect(assigns(:seller).id).to eql(@seller.id)
      expect(assigns(:seller).name).to eql(@seller.name)
      expect(assigns(:seller).store).to eql(@seller.store)
    end
  end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "GET #create" do
    context "with data correct" do
      before(:each) do
        @store = create(:store, user: @current_user)
        @seller = build(:seller, store: @store)
        post :create, params: {seller: @seller.attributes}
      end

      it "redirect for /sellers" do
        expect(response).to redirect_to('/sellers')
      end

      it "seller created with datas correct" do
        expect(Seller.last.name).to eql(@seller.name)
        expect(Seller.last.store).to eql(@seller.store)
      end
    end

    it "returns status 400 with the wrong data" do
      store = create(:store, user: @current_user)
      seller = build(:seller, name: "", store: store)
      post :create, params: {seller: seller.attributes}
      expect(response).to have_http_status(422)
    end
  end

  describe "GET #update" do
    before(:each) do
      @store = create(:store, user: @current_user)
      @seller = create(:seller, store: @store)
      @seller_attributes = attributes_for(:seller)
      put :update, params: {id: @seller.id, seller: @seller_attributes}
    end

    it "redirect to /sellers" do
      expect(response).to redirect_to('/sellers')
    end

    it "the data was updated correctly" do
      expect(Seller.last).to have_attributes(@seller_attributes)
    end
  end

  describe "GET #destroy" do
    before(:each) do
      @store = create(:store, user: @current_user)
      @seller = create(:seller, store: @store)
      delete :destroy, params: {id: @seller.id}
    end

    it "redirec to /sellers" do
      expect(response).to redirect_to('/sellers')
    end

    it "the store was deleted" do
        expect(Seller.all).to_not include(@seller)
    end
  end

end
