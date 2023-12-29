module Reports
  class RunDisbursementReport
    # TODO: Move this to ENV
    REPORT_FILE_PATH = "tmp/report.csv"

    def initialize
      init_result_csv
    end

    def run
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

      result = ActiveRecord::Base.connection.execute(query)

      result.values.each do |yearly_values|
        pp yearly_values
        append_to_result_csv(yearly_values)
      end
    end

    def init_result_csv
      CSV.open(REPORT_FILE_PATH, "w+") do |csv|
        csv << ["year",
                "Number of disbursements",
                "Amount disbursed to merchants",
                "Amount of order fees"
                #"Number of monthly fees charged",
                #"Amount of monthly fee charged"
              ]
      end
    end

    def append_to_result_csv(yearly_result)
      return if yearly_result.nil?
      CSV.open(REPORT_FILE_PATH, "a+") do |csv|
        csv << yearly_result
      end
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