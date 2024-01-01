module Reports
  class RunDisbursementReport
    REPORT_FILE_PATH = ENV.fetch('REPORT_FILE_PATH')

    def initialize
      init_result_csv
    end

    def run
      disbursement_results = []
      monthly_fee_results = []

      # TODO: Add this to docs.
      Rails.cache.fetch("report/disbursement_results", expires_in: 30.minutes) do
          disbursement_results = ActiveRecord::Base.connection.execute(disbursement_query).values
      end

      Rails.cache.fetch("report/monthly_fee_results", expires_in: 30.minutes) do
        monthly_fee_results = ActiveRecord::Base.connection.execute(monthly_fee_query).values
      end

      disbursement_results.each_with_index do |disbursement_result, index|
        monthly_fee_row =  monthly_fee_results[index] || [0,0]
        append_to_result_csv(disbursement_result, monthly_fee_row)
      end
    end

    def init_result_csv
      CSV.open(REPORT_FILE_PATH, "w+") do |csv|
        csv << ["year",
                "Number of disbursements",
                "Amount disbursed to merchants",
                "Amount of order fees",
                "Number of monthly fees charged",
                "Amount of monthly fee charged"
              ]
      end
    end

    def append_to_result_csv(disbursement_result, monthly_fee_result)
      return if disbursement_result.nil? || monthly_fee_result.nil?

      CSV.open(REPORT_FILE_PATH, "a+") do |csv|
        csv << disbursement_result + monthly_fee_result
      end
    end

    def disbursement_query
      <<~SQL
        SELECT "disbursements"."year" AS "disbursements_year",
               COUNT(*) AS "number_of_disbursements",
               SUM("disbursements"."amount") AS "sum_amount",
               SUM("disbursements"."fee") AS "sum_fee"
          FROM "disbursements" GROUP BY "disbursements"."year"
      SQL
    end

    def monthly_fee_query
      <<~SQL
        SELECT  COUNT(*) AS "number_of_disbursements",
                SUM("disbursements"."monthly_fee") AS "sum_monthly_fee"
          FROM "disbursements"
                WHERE "disbursements"."monthly_fee" > 0 
                GROUP BY "disbursements"."year"
      SQL
    end
  end
end