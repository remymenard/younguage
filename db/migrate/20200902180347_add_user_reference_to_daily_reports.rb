class AddUserReferenceToDailyReports < ActiveRecord::Migration[6.0]
  def change
    add_reference :daily_reports, :user, foreign_key: true
  end
end
