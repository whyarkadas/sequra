namespace :import do
  namespace :merchant do
    desc 'Import merchants from CSV to DB'
    task push: :environment do
      csv_path = ENV.fetch('MERCHANTS_CSV_PATH')
      CsvImport::MerchantImport.new(csv_path, ';').call
    end
  end

  namespace :order do
    desc 'Import orders from CSV to DB'
    task push: :environment do
      csv_path = ENV.fetch('ORDERS_CSV_PATH')
      CsvImport::OrderImport.new(csv_path, ',').call
    end
  end
end
