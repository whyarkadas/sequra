module Reports
  class RunDisbursementReport
    def run
      # TODO: queries should be here..
      puts "RunDisbursementReport running"

      # - Year
      # - Group disbursement based on year
      # - Number of disbursements
      # - Count * of query we group above
      # - Amount disbursed to merchants
      # - Sum(amount) … above query
      # - Amount of order fees
      # - Sum(order_fees) … above query
      # - Number of monthly fees charged (From minimum monthly fee)
      # - count(*)…..Group monthly_fee_payment based on year
      # - Amount of monthly fee charged (From minimum monthly fee)
      # - Sum(amount) … above query

    end

    def disbursements_data
      ActiveRecord::Base.connection.execute(query)
      # [[2022, 0.87e2, 0.87e2], [2023, 0.58e2, 0.58e2]]
    end

    def query
      <<~SQL
        SELECT "disbursements"."year" AS "disbursements_year",
               SUM("disbursements"."amount") AS "sum_amount",
               SUM("disbursements"."fee") AS "sum_amount",
               SUM("disbursements"."monthly_fee") AS "sum_monthly_fee"
          FROM "disbursements" GROUP BY "disbursements"."year"
      SQL
    end
  end
end