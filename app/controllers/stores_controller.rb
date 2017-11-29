class StoresController < ApplicationController
  before_action :set_store, only: [:show, :update, :destroy]

  def show
  end

  def index
    @stores = current_user.stores
  end

  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        format.html { redirect_to "/stores" }
      else
        format.html { redirect_to main_app.root_url, notice: @store.errors }
      end
    end
  end

  def update
    respond_to do |format|
      if @store.update(store_params)
          format.html { redirect_to "/stores" }
      else
        format.html { redirect_to main_app.root_url, notice: @store.errors }
      end
    end
  end

  def destroy
    @store.destroy

    respond_to do |format|
      format.html { redirect_to "/stores" }
    end
  end

  private

  def set_store
    if params.has_key?(:id) && params[:id].to_i != 0
      @store = Store.find(params[:id])
    else
      @store = Store.new
    end
  end

  def store_params
    params.require(:store).permit(:name).merge(user: current_user)
  end

end
