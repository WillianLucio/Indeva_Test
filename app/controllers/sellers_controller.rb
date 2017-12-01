class SellersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_seller, only: [:edit, :show, :update, :destroy]

  def show
  end

  def new
    @seller = Seller.new
  end

  def edit
  end

  def create
    @seller = Seller.new(seller_params)

    respond_to do |format|
      if @seller.save
        format.html { redirect_to "/sellers" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @seller.update(seller_params)
        format.html { redirect_to "/sellers" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @seller.destroy

    respond_to do |format|
      format.html { redirect_to "/sellers" }
    end
  end

  private

  def set_seller
    @seller = Seller.find(params[:id])
  end

  def seller_params
    params.require(:seller).permit(:name, :store_id)
  end

end
