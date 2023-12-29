require 'csv'

module CsvImport
  class Base
    BULK_IMPORT_BATCH_SIZE = 100

    def initialize(csv_path, separator)
      @csv_path = csv_path
      @separator = separator
    end

    def call
      csv_in_bulk(@csv_path) do |rows|
        import_in_batch(rows)
      end
    end

    private

    def csv_in_bulk(csv_path)
      rows = []
      CSV.foreach(csv_path, headers: true, col_sep: @separator) do |row|
        rows << row
        if rows.size == BULK_IMPORT_BATCH_SIZE
          yield(rows)
          rows = []
        end
      end
      yield(rows) if rows.present?
      true
    end
  end
end
