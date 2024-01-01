namespace :report do
  namespace :disbursement do
    desc 'Import merchants from CSV to DB'
    task yearly: :environment do
      Reports::BuildDisbursementReport.new.run
    end
  end

  # TODO: Might also build need monthly report in the future.
end
