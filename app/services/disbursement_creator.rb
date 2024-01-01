class DisbursementCreator
  def initialize(disbursement_amount, disbursement_fee, monthly_fee,id, disbursement_date)
    @disbursement_amount = disbursement_amount
    @disbursement_fee = disbursement_fee
    @monthly_fee = monthly_fee
    @merchant_id = id
    @creation_date = disbursement_date
  end

  def run
    Disbursement.create!(
      creation_date: @creation_date,
      amount: @disbursement_amount,
      fee: @disbursement_fee,
      year: @creation_date.year,
      month: @creation_date.month,
      merchant_id: @merchant_id,
      monthly_fee: @monthly_fee
    )
  end
end