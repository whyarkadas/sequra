class DisbursementsController < ApplicationController
  before_action :set_disbursement, only: %i[ show update destroy ]

  # GET /disbursements
  def index
    @disbursements = Disbursement.all

    render json: @disbursements
  end

  # GET /disbursements/1
  def show
    render json: @disbursement
  end

  # POST /disbursements
  def create
    @disbursement = Disbursement.new(disbursement_params)

    if @disbursement.save
      render json: @disbursement, status: :created, location: @disbursement
    else
      render json: @disbursement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /disbursements/1
  def update
    if @disbursement.update(disbursement_params)
      render json: @disbursement
    else
      render json: @disbursement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /disbursements/1
  def destroy
    @disbursement.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disbursement
      @disbursement = Disbursement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def disbursement_params
      params.require(:disbursement).permit(:merchant_id, :amount, :creation_date, :fee, :year, :month)
    end
end
