class ResetDailyReport < ApplicationJob
  queue_as :default

  def perform
    DailyReports::ResetService.new.call
  end
end
