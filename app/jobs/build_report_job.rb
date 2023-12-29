class BuildReportJob < ApplicationJob
  def perform
    Reports::RunDisbursementReport.new.run
  end
end
