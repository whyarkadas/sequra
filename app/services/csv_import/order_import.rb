module CsvImport
  class OrderImport < Base
    # TODO: We might have too much orders so could be done async with sidekiq.
    private

    def import_in_batch(rows)
      objs = rows.map do |row|
        Order.new(
          merchant_reference: row.fetch('merchant_reference'),
          amount: row.fetch('amount'),
          creation_date: row.fetch('created_at'),
          id_key:row.fetch('id')
        )
      end
      Order.import!(objs.compact)
    end
  end
end
