module Reports
  class BuildDisbursementReport
    def run
      # TODO: Check if we have this in cache
      # else run job
      puts "We start building disbursement report for you, your report will be ready in tmp folder check after a while"
      BuildReportJob.perform_later
    end
  end
end