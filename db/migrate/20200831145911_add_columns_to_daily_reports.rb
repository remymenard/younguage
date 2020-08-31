class AddColumnsToDailyReports < ActiveRecord::Migration[6.0]
  def change
    add_column :daily_reports, :day, :string
    add_column :daily_reports, :letter, :string
  end
end
