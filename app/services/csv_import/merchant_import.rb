module CsvImport
  class MerchantImport < Base
    private

    def import_in_batch(rows)
      objs = rows.map do |row|
        Merchant.new(
            reference: row.fetch('reference'),
            email: row.fetch('reference'),
            live_on: row.fetch('live_on'),
            disbursement_frequency: row.fetch('disbursement_frequency')&.downcase.to_sym,
            minimum_monthly_fee: row.fetch('minimum_monthly_fee'),
            id_key: row.fetch('id')
          )
      end
      Merchant.import!(objs.compact)

      objs.compact.each do |merchant|
        merchant.run_callbacks(:create) { true }
      end
    end
  end
end
