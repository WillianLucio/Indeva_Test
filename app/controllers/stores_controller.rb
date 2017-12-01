class StoresController < ApplicationController
  before_action :authenticate_user!, except: [:opened]
  before_action :set_store, only: [:edit, :show, :update, :destroy]

  def show
  end

  def new
    @store = Store.new
  end

  def edit
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
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to "/stores" }
      else
        format.html { render :new, status: :unprocessable_entity }
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
    @store = Store.find(params[:id])

    if @store.user.id == current_user.id
      @store
    else
      @store = Store.new
    end
  end

  def store_params
    params.require(:store).permit(:name).merge(user: current_user)
  end

end
