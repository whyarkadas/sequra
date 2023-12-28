class DisbursementCreator
  def initialize(disbursement_amount, disbursement_fee, id)
    @disbursement_amount = disbursement_amount
    @disbursement_fee = disbursement_fee
    @merchant_id = id
  end

  def run
    Disbursement.create!(
      creation_date: Date.today,
      amount: @disbursement_amount,
      fee: @disbursement_fee,
      year: Date.current.year,
      month: Date.current.month,
      merchant_id: @merchant_id
    )
  end
end