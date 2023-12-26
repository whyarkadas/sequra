class MerchantsController < ApplicationController
  before_action :set_merchant, only: %i[ show update destroy ]

  # GET /merchants
  def index
    @merchants = Merchant.all

    render json: @merchants
  end

  # GET /merchants/1
  def show
    render json: @merchant
  end

  # POST /merchants
  def create
    @merchant = Merchant.new(merchant_params)

    if @merchant.save
      render json: @merchant, status: :created, location: @merchant
    else
      render json: @merchant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /merchants/1
  def update
    if @merchant.update(merchant_params)
      render json: @merchant
    else
      render json: @merchant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /merchants/1
  def destroy
    @merchant.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def merchant_params
      params.require(:merchant).permit(:reference, :email, :live_on, :disbursement_frequency, :minimum_monthly_fee, :id_key, :monthly_fee_payment)
    end
end
